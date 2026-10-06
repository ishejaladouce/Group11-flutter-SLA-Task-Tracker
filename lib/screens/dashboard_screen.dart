import 'package:flutter/material.dart';
import '../models/team_member.dart';
import '../theme/app_theme.dart';
import '../widgets/count_card.dart';
import '../widgets/progress_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final member = ModalRoute.of(context)!.settings.arguments as TeamMember;

    // replace these numbers with real counts from the database
    const total = 10;
    const completed = 4;
    const atRisk = 2;
    const overdue = 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/task-form'),
        icon: const Icon(Icons.add),
        label: const Text('New task'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          Text('Hello, ${member.name}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.small),
          Text(member.role, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.large),
          const ProgressCard(completed: completed, total: total),
          const SizedBox(height: AppSpacing.medium),
          const Row(
            children: [
              Expanded(
                child: CountCard(
                  label: 'Total tasks',
                  value: total,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: CountCard(
                  label: 'Completed',
                  value: completed,
                  color: AppColors.completed,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          const Row(
            children: [
              Expanded(
                child: CountCard(
                  label: 'At risk',
                  value: atRisk,
                  color: AppColors.atRisk,
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: CountCard(
                  label: 'Overdue',
                  value: overdue,
                  color: AppColors.overdue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/tasks'),
            child: const Text('View all tasks'),
          ),
          const SizedBox(height: AppSpacing.small),
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/team'),
            child: const Text('Team members'),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}