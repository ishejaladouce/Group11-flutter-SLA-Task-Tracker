import 'package:flutter/material.dart';

import '../models/team_member.dart';
import '../task_management/task_presentation.dart';
import '../theme/app_theme.dart';
import '../utils/demo_members.dart';

class TaskFormScreen extends StatefulWidget {
  final TaskPresentation? task;
  final TaskStore store;

  const TaskFormScreen({super.key, required this.store, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  static const _priorities = ['Low', 'Medium', 'High'];
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _progressController;
  String? _assignee;
  String? _priority;
  DateTime? _deadline;
  bool _saving = false;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(
      text: task?.description ?? '',
    );
    _progressController = TextEditingController(
      text: task?.progress.toString() ?? '0',
    );
    _assignee = task?.assignee;
    _priority = task?.priority;
    _deadline = task?.deadline;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _chooseDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final oldTask = widget.task;
    final draft = TaskPresentation(
      id: oldTask?.id ?? '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      assignee: _assignee!,
      priority: _priority!,
      deadline: _deadline!,
      progress: int.parse(_progressController.text.trim()),
      // TODO(Manuelle): populate this from the shared SLA helper.
      slaStatus: oldTask?.slaStatus ?? 'On Track',
    );
    final saved = widget.store.save(draft);
    Navigator.pop(context, saved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit task' : 'Create task')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          children: [
            TextFormField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            DropdownButtonFormField<String>(
              value: _assignee,
              decoration: const InputDecoration(
                labelText: 'Assignee',
                border: OutlineInputBorder(),
              ),
              items: demoMembers
                  .map(
                    (TeamMember member) => DropdownMenuItem(
                      value: member.name,
                      child: Text(member.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _assignee = value),
            ),
            const SizedBox(height: AppSpacing.medium),
            DropdownButtonFormField<String>(
              value: _priority,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: _priorities
                  .map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _priority = value),
            ),
            const SizedBox(height: AppSpacing.medium),
            FormField<DateTime>(
              initialValue: _deadline,
              builder: (field) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      await _chooseDeadline();
                      field.didChange(_deadline);
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      _deadline == null
                          ? 'Choose deadline'
                          : MaterialLocalizations.of(context)
                                .formatMediumDate(_deadline!),
                    ),
                  ),
                  if (field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 6),
                      child: Text(
                        field.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            TextFormField(
              controller: _progressController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Progress',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: Text(
                  _saving
                      ? 'Saving...'
                      : (_isEditing ? 'Save changes' : 'Create task'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
