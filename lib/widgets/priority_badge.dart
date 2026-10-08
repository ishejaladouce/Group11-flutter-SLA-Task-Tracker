import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_badge.dart';

class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({super.key, required this.priority});

  Color get color {
    switch (priority) {
      case 'High':
        return AppColors.overdue;
      case 'Medium':
        return AppColors.atRisk;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBadge(label: priority, color: color);
  }
}