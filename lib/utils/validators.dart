/// Shared field validation used by the task create and edit forms.
class Validators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? title(String? value) => requiredField(value, 'Task title');

  /// Description is optional; trim it when saving rather than restricting it.
  static String? description(String? value) => null;

  static String? assignee(String? value, Iterable<String> validAssignees) {
    if (value == null || value.trim().isEmpty) {
      return 'Assignee is required';
    }
    if (!validAssignees.contains(value.trim())) {
      return 'Select a valid team member';
    }
    return null;
  }

  static String? priority(String? value, Iterable<String> validPriorities) {
    if (value == null || value.trim().isEmpty) {
      return 'Priority is required';
    }
    if (!validPriorities.contains(value.trim())) {
      return 'Select a valid priority';
    }
    return null;
  }

  static String? deadline(DateTime? value) {
    if (value == null) {
      return 'Deadline is required';
    }
    return null;
  }

  static String? progress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Progress is required';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter progress as a whole number';
    }
    if (parsed < 0 || parsed > 100) {
      return 'Progress must be between 0 and 100';
    }
    return null;
  }
}
