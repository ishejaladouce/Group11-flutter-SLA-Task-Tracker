import 'package:flutter/material.dart';

import '../task_management/task_presentation.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';
import 'priority_badge.dart';
import 'status_badge.dart';

class TaskCard extends StatelessWidget {
  final TaskPresentation task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final dueText = MaterialLocalizations.of(context).formatMediumDate(task.deadline);
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(task.title, style: Theme.of(context).textTheme.titleMedium),
              ),
              PriorityBadge(priority: task.priority),
            ],
          ),
          const SizedBox(height: AppSpacing.small),
          Text('Assigned to ${task.assignee}', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.medium),
          Row(
            children: [
              Expanded(child: LinearProgressIndicator(value: task.progress / 100)),
              const SizedBox(width: AppSpacing.small),
              Text('${task.progress}%'),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          Row(
            children: [
              Expanded(child: Text('Due $dueText', style: Theme.of(context).textTheme.bodySmall)),
              StatusBadge(status: task.slaStatus),
            ],
          ),
        ],
      ),
    );
  }
}
