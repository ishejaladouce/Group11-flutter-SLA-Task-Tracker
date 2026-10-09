import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/priority_badge.dart';
import '../widgets/status_badge.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Task _task = widget.task;

  Future<void> _editTask() async {
    final result = await Navigator.pushNamed(
      context,
      '/task-form',
      arguments: _task,
    );
    if (result is Task && mounted) {
      setState(() => _task = result);
    }
  }

  Future<void> _deleteTask() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete task?'),
        content: const Text('This task will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && mounted) {
      await DatabaseService.instance.deleteTask(_task.id!);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatMediumDate(_task.deadline);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task details'),
        actions: [
          IconButton(onPressed: _editTask, tooltip: 'Edit task', icon: const Icon(Icons.edit)),
          IconButton(onPressed: _deleteTask, tooltip: 'Delete task', icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          Text(_task.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.medium),
          Wrap(
            spacing: AppSpacing.small,
            runSpacing: AppSpacing.small,
            children: [PriorityBadge(priority: _task.priority), StatusBadge(status: _task.slaStatus)],
          ),
          const SizedBox(height: AppSpacing.large),
          AppCard(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(label: 'Assignee', value: _task.assignee),
              const Divider(height: AppSpacing.large),
              _DetailRow(label: 'Deadline', value: date),
              const Divider(height: AppSpacing.large),
              _DetailRow(label: 'Progress', value: '${_task.progress}%'),
            ],
          )),
          const SizedBox(height: AppSpacing.large),
          Text('Description', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.small),
          Text(
            _task.description.isEmpty ? 'No description provided.' : _task.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.large),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: _task.progress / 100, minHeight: 10),
          ),
          const SizedBox(height: AppSpacing.small),
          Text('${_task.progress}% complete', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.large),
          ElevatedButton.icon(
            onPressed: _editTask,
            icon: const Icon(Icons.edit),
            label: const Text('Edit task'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text(label, style: Theme.of(context).textTheme.bodySmall)),
        Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}
