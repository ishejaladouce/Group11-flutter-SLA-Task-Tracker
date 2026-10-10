import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/utils/validators.dart';

void main() {
  group('Validators.requiredField', () {
    test('rejects null, empty, and whitespace-only values', () {
      expect(Validators.requiredField(null, 'Name'), isNotNull);
      expect(Validators.requiredField('', 'Name'), isNotNull);
      expect(Validators.requiredField('   ', 'Name'), isNotNull);
    });

    test('accepts a non-empty value', () {
      expect(Validators.requiredField('Task', 'Name'), isNull);
    });
  });

  group('Validators.title', () {
    test('rejects empty titles and accepts a non-empty title', () {
      expect(Validators.title(null), isNotNull);
      expect(Validators.title('  '), isNotNull);
      expect(Validators.title('Prepare report'), isNull);
    });
  });

  group('Validators.description', () {
    test('accepts empty and non-empty descriptions because it is optional', () {
      expect(Validators.description(null), isNull);
      expect(Validators.description(''), isNull);
      expect(Validators.description('More details'), isNull);
    });
  });

  group('Validators.assignee', () {
    const validAssignees = ['Avery', 'Jordan'];

    test('rejects empty and unknown assignees', () {
      expect(Validators.assignee(null, validAssignees), isNotNull);
      expect(Validators.assignee('  ', validAssignees), isNotNull);
      expect(Validators.assignee('Unknown', validAssignees), isNotNull);
    });

    test('accepts a valid assignee', () {
      expect(Validators.assignee('Avery', validAssignees), isNull);
    });
  });

  group('Validators.priority', () {
    const validPriorities = ['Low', 'Medium', 'High'];

    test('rejects empty and unknown priorities', () {
      expect(Validators.priority(null, validPriorities), isNotNull);
      expect(Validators.priority('  ', validPriorities), isNotNull);
      expect(Validators.priority('Urgent', validPriorities), isNotNull);
    });

    test('accepts a valid priority', () {
      expect(Validators.priority('High', validPriorities), isNull);
    });
  });

  group('Validators.deadline', () {
    test('rejects a missing deadline and accepts a selected deadline', () {
      expect(Validators.deadline(null), isNotNull);
      expect(Validators.deadline(DateTime(2026, 10, 10)), isNull);
    });
  });

  group('Validators.progress', () {
    test('rejects empty, non-numeric, and out-of-range progress', () {
      expect(Validators.progress(null), isNotNull);
      expect(Validators.progress('  '), isNotNull);
      expect(Validators.progress('ten'), isNotNull);
      expect(Validators.progress('-1'), isNotNull);
      expect(Validators.progress('101'), isNotNull);
    });

    test('accepts whole-number progress from 0 through 100', () {
      expect(Validators.progress('0'), isNull);
      expect(Validators.progress('50'), isNull);
      expect(Validators.progress('100'), isNull);
    });
  });
}
