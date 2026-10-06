import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor ?? AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: child,
        ),
      ),
    );
  }
}