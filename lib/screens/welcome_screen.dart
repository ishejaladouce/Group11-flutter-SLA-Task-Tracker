import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, Color(0xFF115E59)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(top: -60, right: -60, child: _circle(200)),
            Positioned(bottom: -80, left: -80, child: _circle(220)),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.large),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.task_alt,
                            size: 48,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.large),
                        const Text(
                          'Welcome to\nTask Tracker',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        const Text(
                          'Plan the work, share it with your team and stay ahead of every deadline.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: AppSpacing.large),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Feature(
                              icon: Icons.add_task,
                              text: 'Create and assign tasks',
                            ),
                            _Feature(
                              icon: Icons.timer_outlined,
                              text: 'See what is on track or at risk',
                            ),
                            _Feature(
                              icon: Icons.bar_chart,
                              text: 'Follow progress on one dashboard',
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.large),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/select'),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get started',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Feature({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}