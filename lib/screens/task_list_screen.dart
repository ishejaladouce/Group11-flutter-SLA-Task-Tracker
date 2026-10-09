import 'package:flutter/material.dart';

import '../task_management/task_presentation.dart';
import '../theme/app_theme.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  final TaskStore store;

  const TaskListScreen({super.key, required this.store});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _searchController = TextEditingController();
  String _statusFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openTask(TaskPresentation task) async {
    await Navigator.pushNamed(context, '/task-details', arguments: task);
    if (mounted) setState(() {});
  }

  Future<void> _createTask() async {
    await Navigator.pushNamed(context, '/task-form');
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final tasks = widget.store.tasks.where((task) {
      final matchesQuery = task.title.toLowerCase().contains(query) ||
          task.assignee.toLowerCase().contains(query);
      final matchesStatus = _statusFilter == 'All' || task.slaStatus == _statusFilter;
      return matchesQuery && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createTask,
        icon: const Icon(Icons.add),
        label: const Text('New task'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search title or assignee',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                DropdownButtonFormField<String>(
                  initialValue: _statusFilter,
                  decoration: const InputDecoration(
                    labelText: 'SLA status',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  items: const ['All', 'Completed', 'Overdue', 'At Risk', 'On Track']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) => setState(() => _statusFilter = value ?? 'All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks match your search.'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.medium, 0, AppSpacing.medium, 96,
                    ),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.medium),
                    itemBuilder: (context, index) => TaskCard(
                      task: tasks[index],
                      onTap: () => _openTask(tasks[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
