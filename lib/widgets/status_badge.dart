import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_badge.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color get color {
    switch (status) {
      case 'Completed':
        return AppColors.completed;
      case 'Overdue':
        return AppColors.overdue;
      case 'At Risk':
        return AppColors.atRisk;
      default:
        return AppColors.onTrack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBadge(label: status, color: color);
  }
}