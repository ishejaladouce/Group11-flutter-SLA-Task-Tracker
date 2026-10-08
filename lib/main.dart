import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/team_members_screen.dart';
import 'screens/user_selection_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/placeholder_screen.dart';

void main() {
  runApp(const TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const UserSelectionScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/team': (context) => const TeamMembersScreen(),
        '/tasks': (context) => const PlaceholderScreen(title: 'Tasks'),
        '/task-details': (context) =>
            const PlaceholderScreen(title: 'Task details'),
        '/task-form': (context) => const PlaceholderScreen(title: 'Task form'),
      },
    );
  }
}