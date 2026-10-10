import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/utils/sla_helper.dart';

void main() {
  final task = Task(
    id: 7,
    title: 'Write report',
    description: 'Technical report draft',
    assignee: 'Manuelle',
    priority: 'High',
    deadline: DateTime(2026, 10, 12),
    progress: 60,
  );

  test('toMap the fromMap returns the same task', () {
    final copy = Task.fromMap(task.toMap());
    expect(copy.id, 7);
    expect(copy.title, task.title);
    expect(copy.description, task.description);
    expect(copy.assignee, task.assignee);
    expect(copy.priority, task.priority);
    expect(copy.deadline, task.deadline);
    expect(copy.progress, 60);
  });

  test('progress 100 means completed, so SLA status is Completed', () {
    final done = task.copyWith(progress: 100);
    expect(done.isCompleted, true);
    expect(done.slaStatus, SlaStatus.completed);
  });
}