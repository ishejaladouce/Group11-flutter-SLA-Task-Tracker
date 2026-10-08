/// Form and display data owned by the task UI.
class TaskPresentation {
  final String id;
  final String title;
  final String description;
  final String assignee;
  final String priority;
  final DateTime deadline;
  final int progress;

  /// Sample display value only
  final String slaStatus;

  const TaskPresentation({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.priority,
    required this.deadline,
    required this.progress,
    required this.slaStatus,
  });

  TaskPresentation copyWith({
    String? id,
    String? title,
    String? description,
    String? assignee,
    String? priority,
    DateTime? deadline,
    int? progress,
    String? slaStatus,
  }) {
    return TaskPresentation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      progress: progress ?? this.progress,
      slaStatus: slaStatus ?? this.slaStatus,
    );
  }
}

abstract interface class TaskStore {
  List<TaskPresentation> get tasks;
  TaskPresentation save(TaskPresentation task);
  void delete(String id);
}

/// In-memory demonstration data; it is not persistent.
class MockTaskStore implements TaskStore {
  MockTaskStore._();

  static final MockTaskStore instance = MockTaskStore._();

  final List<TaskPresentation> _tasks = [
    TaskPresentation(
      id: 'demo-1',
      title: 'Prepare project brief',
      description:
          'Write the initial project overview and share it with the team.',
      assignee: 'Ladouce',
      priority: 'High',
      deadline: DateTime(2026, 10, 10),
      progress: 70,
      slaStatus: 'At Risk',
    ),
    TaskPresentation(
      id: 'demo-2',
      title: 'Review API requirements',
      description: 'Confirm the required fields and expected API behavior.',
      assignee: 'Manuelle',
      priority: 'Medium',
      deadline: DateTime(2026, 10, 18),
      progress: 35,
      slaStatus: 'On Track',
    ),
    TaskPresentation(
      id: 'demo-3',
      title: 'Build task form layout',
      description: 'Create and review the task form fields.',
      assignee: 'Kevin',
      priority: 'Low',
      deadline: DateTime(2026, 10, 5),
      progress: 100,
      slaStatus: 'Completed',
    ),
    TaskPresentation(
      id: 'demo-4',
      title: 'Publish sprint notes',
      description: 'Upload the sprint summary for the team.',
      assignee: 'Ladouce',
      priority: 'Medium',
      deadline: DateTime(2026, 10, 1),
      progress: 20,
      slaStatus: 'Overdue',
    ),
  ];

  int _nextId = 1;

  @override
  List<TaskPresentation> get tasks => List.unmodifiable(_tasks);

  @override
  TaskPresentation save(TaskPresentation task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      final id = task.id.isEmpty ? 'new-${_nextId++}' : task.id;
      final saved = task.copyWith(id: id);
      _tasks.add(saved);
      return saved;
    }
    _tasks[index] = task;
    return task;
  }

  @override
  void delete(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
