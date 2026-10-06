import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/demo_members.dart';
import '../widgets/member_tile.dart';

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team members')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.medium),
        itemCount: demoMembers.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.medium),
        itemBuilder: (context, index) {
          return MemberTile(member: demoMembers[index]);
        },
      ),
    );
  }
}