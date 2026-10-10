import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/utils/sla_helper.dart';

void main() {
  final now = DateTime(2026, 10, 9, 14, 30);

  String status(DateTime deadline, {bool done = false}) => SlaHelper.statusFor(
    deadline: deadline,
    isCompleted: done,
    now: now,
  );

  test('completed task is Completed even if past its deadline', () {
    expect(status(DateTime(2026, 10, 1), done: true), SlaStatus.completed);
  });

  test('incomplete task past its deadline is Overdue', () {
    expect(status(DateTime(2026, 10, 8)), SlaStatus.overdue);
  });

  test('task due today is AT Risk, not Overdue', () {
    expect(status(DateTime(2026, 10, 9)), SlaStatus.atRisk);
  });

  test('task due in 1 or 2 day is At Risk', () {
    expect(status(DateTime(2026, 10, 10)), SlaStatus.atRisk);
    expect(status(DateTime(2026, 10, 11)), SlaStatus.atRisk);
  });

  test('task due in 3+ days in ON Track', () {
    expect(status(DateTime(2026, 10, 12)), SlaStatus.onTrack);
  });
}