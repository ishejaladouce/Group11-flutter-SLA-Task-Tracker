import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/main.dart';

void main() {
  testWidgets('shows the user selection screen', (tester) async {
    await tester.pumpWidget(const TaskTrackerApp());

    expect(find.text('Task Tracker'), findsOneWidget);
    expect(find.text('Kevin'), findsOneWidget);
  });
}