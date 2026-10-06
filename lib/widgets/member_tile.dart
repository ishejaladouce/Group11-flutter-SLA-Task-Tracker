import 'package:flutter/material.dart';
import '../models/team_member.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';

class MemberTile extends StatelessWidget {
  final TeamMember member;
  final bool selected;
  final VoidCallback? onTap;

  const MemberTile({
    super.key,
    required this.member,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: selected ? AppColors.primary : null,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text(
              member.name[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: AppSpacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  member.role,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }
}