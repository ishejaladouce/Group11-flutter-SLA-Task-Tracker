import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';

class ProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = total == 0 ? 0 : completed / total;
    final int percent = (progress * 100).round();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project progress',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.medium),
          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.primary,
            backgroundColor: AppColors.border,
          ),
          const SizedBox(height: AppSpacing.small),
          Text('$percent% done ($completed of $total tasks)',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}