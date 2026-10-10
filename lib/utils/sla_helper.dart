/// the four SLA labels used everywhere in the application
abstract final class SlaStatus {
  static const completed = 'Completed';
  static const overdue = 'Overdue';
  static const atRisk = 'At Risk';
  static const onTrack = 'On Track';

  static const all = [completed, overdue, atRisk, onTrack];
}

class SlaHelper {
  /// a task is "At Risk" when it's due within this many days
  static const int atRiskDays = 2;

  static String statusFor({
    required DateTime deadline,
    required bool isCompleted,
    DateTime? now,
  }) {
    if (isCompleted) {
      return SlaStatus.completed;
    }

    final today = _dateOnly(now ?? DateTime.now());
    final dueDay = _dateOnly(deadline);
    final daysLeft = dueDay.difference(today).inDays;

    if (daysLeft < 0) {
      return SlaStatus.overdue;
    }

    if (daysLeft <= atRiskDays) {
      return SlaStatus.atRisk;
    }

    return SlaStatus.onTrack;
  }

  static DateTime _dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);
}