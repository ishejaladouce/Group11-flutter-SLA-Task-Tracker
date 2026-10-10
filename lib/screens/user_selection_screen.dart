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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, Color(0xFF115E59)],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.large,
                      AppSpacing.small,
                      AppSpacing.large,
                      AppSpacing.large,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSpacing.small),
                        const Text(
                          'Who is using the app?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.small),
                        const Text(
                          'Pick your name to continue.',
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.large),
                  child: Column(
                    children: [
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
                      const SizedBox(height: AppSpacing.medium),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: selected == null ? null : goToDashboard,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Continue'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}