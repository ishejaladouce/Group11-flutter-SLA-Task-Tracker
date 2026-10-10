import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/utils/task_stats.dart';

Task _task({required int daysFromNow, required int progress}) {
  final now = DateTime.now();
  return Task(
    title: 'Test task',
    description: '',
    assignee: 'Kevin',
    priority: 'Low',
    deadline: DateTime(now.year, now.month, now.day + daysFromNow),
    progress: progress,
  );
}

void main() {
  test('empty list gives zeros and no divide-by-zero', () {
    final stats = TaskStats.fromTasks([]);
    expect(stats.total, 0);
    expect(stats.completionPercent, 0);
    expect(stats.averageProgress, 0);
  });

  test('counts each SLA status correctly', () {
    final stats = TaskStats.fromTasks([
      _task(daysFromNow: -5, progress: 100),
      _task(daysFromNow: -2, progress: 20),
      _task(daysFromNow: 1, progress: 50),
      _task(daysFromNow: 10, progress: 0),
    ]);

    expect(stats.total, 4);
    expect(stats.completed, 1);
    expect(stats.overdue, 1);
    expect(stats.atRisk, 1);
    expect(stats.onTrack, 1);
    expect(stats.completionPercent, 25);
    expect(stats.averageProgress, 43);
  });
}