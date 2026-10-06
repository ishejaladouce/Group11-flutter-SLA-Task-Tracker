import 'package:flutter/material.dart';
import '../models/team_member.dart';
import '../theme/app_theme.dart';
import '../utils/demo_members.dart';
import '../widgets/member_tile.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  TeamMember? selected;

  void goToDashboard() {
    Navigator.pushNamed(context, '/dashboard', arguments: selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.large),
              Text('Task Tracker',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.small),
              Text('Choose who you are to continue.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.large),
              Expanded(
                child: ListView.separated(
                  itemCount: demoMembers.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.medium),
                  itemBuilder: (context, index) {
                    final member = demoMembers[index];
                    return MemberTile(
                      member: member,
                      selected: selected?.id == member.id,
                      onTap: () {
                        setState(() {
                          selected = member;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selected == null ? null : goToDashboard,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}