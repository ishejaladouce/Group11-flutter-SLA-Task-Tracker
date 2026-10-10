import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/main.dart';

void main() {
  testWidgets('welcome screen leads to user selection', (tester) async {
    await tester.pumpWidget(const TaskTrackerApp());

    expect(find.text('Get started'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Kevin'), findsOneWidget);
  });
}