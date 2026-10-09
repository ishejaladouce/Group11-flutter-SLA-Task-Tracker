import '../models/task.dart';

/// sample tasks inserted the first time the db is created
List<Task> buildDemoTasks({DateTime? now}) {
  final today = now ?? DateTime.now();
  DateTime inDays(int days) =>
    DateTime(today.year, today.month, today.day + days);
  
  return [
    Task(
      title: 'Prepare project brief',
      description: 'Write the intial project overview and share it with the team.',
      assignee: 'Ladouce',
      priority: 'High',
      deadline: inDays(1),
      progress: 70,
    ),
    Task(
      title: 'Review API requirements',
      description: 'Confirm the required fields and expected behaviour.',
      assignee: 'Manuelle',
      priority: 'Medium',
      deadline: inDays(9),
      progress: 35,
    ),
    Task(
      title: 'Build task form layout',
      description: 'Create and review the task form fields.',
      assignee: 'Kevin',
      priority: 'Low',
      deadline: inDays(-4),
      progress: 100,
    ),
    Task(
      title: 'Publish sprint notes',
      description: 'Upload the sprint summary for the team.',
      assignee: 'Ladouce',
      priority: 'Meduim',
      deadline: inDays(-3),
      progress: 20,
    ),
  ];
}