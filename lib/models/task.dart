import '../utils/sla_helper.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final String assignee;
  final String priority;
  final DateTime deadline;
  final int progress;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.priority,
    required this.deadline,
    required this.progress,
  });

  bool get isCompleted => progress >= 100;

  String get slaStatus =>
    SlaHelper.statusFor(deadline: deadline, isCompleted: isCompleted);
  
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? assignee,
    String? priority,
    DateTime? deadline,
    int? progress,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      progress: progress ?? this.progress,
    );
  }

  /// converts to a row for SQLite. dates are stored as ISO-8601 text
  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'description': assignee,
    'priority': priority,
    'deadline': deadline.toIso8601String(),
    'progress': progress,
  };

  factory Task.fromMap(Map<String, Object?> map) => Task(
    id: map['id'] as int,
    title: map['title'] as String,
    description: map['description'] as String,
    assignee: map['assignee'] as String,
    priority: map['priority'] as String,
    deadline: DateTime.parse(map['deadline'] as String),
    progress: map['progress'] as int,
  );
}