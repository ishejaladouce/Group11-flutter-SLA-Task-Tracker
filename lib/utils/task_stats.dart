import '../models/task.dart';
import 'sla_helper.dart';

/// stat cards shown on the dashboard
class TaskStats {
  final int total;
  final int completed;
  final int onTrack;
  final int atRisk;
  final int overdue;
  final int averageProgress;

  const TaskStats({
    required this.total,
    required this.completed,
    required this.onTrack,
    required this.atRisk,
    required this.overdue,
    required this.averageProgress,
  });

  int get completionPercent => 
    total == 0 ? 0 : (completed / total * 100).round();

  factory TaskStats.fromTasks(List<Task> tasks) {
    var completed = 0;
    var onTrack = 0;
    var atRisk = 0;
    var overdue = 0;
    var progressSum = 0;

    for (final task in tasks) {
        progressSum += task.progress;

        switch (task.slaStatus) {
            case SlaStatus.completed:
                completed++;
            case SlaStatus.onTrack:
                onTrack++;
            case SlaStatus.atRisk:
                atRisk++;
            case SlaStatus.overdue:
                overdue++;
        }
    }

    return TaskStats(
        total: tasks.length,
        completed: completed,
        onTrack: onTrack,
        atRisk: atRisk,
        overdue: overdue,
        averageProgress:
            tasks.isEmpty ? 0 : (progressSum / tasks.length).round(),
    );
  }

}