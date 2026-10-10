import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/task_details_screen.dart';
import 'screens/task_form_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/team_members_screen.dart';
import 'models/task.dart';
import 'screens/user_selection_screen.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

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
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.2,
            ),
          ),
          child: ColoredBox(
            color: AppColors.background,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: child!,
              ),
            ),
          ),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/select': (context) => const UserSelectionScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/team': (context) => const TeamMembersScreen(),
        '/tasks': (context) => TaskListScreen(),
        '/task-details': (context) => TaskDetailsScreen(
              task: ModalRoute.of(context)!.settings.arguments! as Task,
            ),
        '/task-form': (context) => TaskFormScreen(
              task: ModalRoute.of(context)?.settings.arguments as Task?,
            ),
      },
    );
  }
}