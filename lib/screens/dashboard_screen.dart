import 'package:flutter/material.dart';

import '../models/team_member.dart';
import '../models/task.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../utils/task_stats.dart';
import '../widgets/count_card.dart';
import '../widgets/progress_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Task> _tasks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await DatabaseService.instance.getTasks();
      if (mounted) {
        setState(() => _tasks = tasks);
      }
    } on StorageException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _open(String route) async {
    await Navigator.pushNamed(context, route);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final member = ModalRoute.of(context)!.settings.arguments as TeamMember;
    final stats = TaskStats.fromTasks(_tasks);
    final myOpenTasks = _tasks
      .where((t) => t.assignee == member.name && !t.isCompleted)
      .length;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _open('/task-form'),
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
      body: _loading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(AppSpacing.medium),
            children: [
              Text('Hello, ${member.name}',
                style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.small),
              Text(member.role, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: AppSpacing.large),
              ProgressCard(completed: stats.completed, total: stats.total),
              const SizedBox(height: AppSpacing.medium),
          
              Row(
                children: [
                  Expanded(
                    child: CountCard(
                      label: 'Total Tasks',
                      value: stats.total,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: CountCard(
                      label: 'Completed',
                      value: stats.completed,
                      color: AppColors.completed,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: AppSpacing.medium),
              Row(
                children: [
                  Expanded(
                    child: CountCard(
                      label: 'On Track',
                      value: stats.onTrack,
                      color: AppColors.onTrack
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: CountCard(
                      label: 'At Risk',
                      value: stats.atRisk,
                      color: AppColors.atRisk,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CountCard(
                      label: 'Overdue',
                      value: stats.overdue,
                      color: AppColors.overdue
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: CountCard(
                      label: 'My Open Tasks',
                      value: myOpenTasks,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.large),
              ElevatedButton(
                onPressed: () => _open('/tasks'),
                child: const Text('View all tasks'),
              ),
              const SizedBox(height: AppSpacing.small),
              OutlinedButton(
                onPressed: () => _open('/team'),
                child: const Text('Team members'),
              ),

              const SizedBox(height: 80),
            ],
          ),
      );
  }
}