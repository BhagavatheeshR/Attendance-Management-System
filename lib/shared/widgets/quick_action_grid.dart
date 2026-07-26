import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';

class QuickAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const QuickAction({required this.icon, required this.label, required this.onTap, this.color});
}

/// Responsive grid of quick-action tiles — used on every dashboard so
/// "Add Student", "Take Attendance", "Create Timetable" etc. always look
/// the same regardless of role.
class QuickActionGrid extends StatelessWidget {
  final List<QuickAction> actions;
  final int columns;

  const QuickActionGrid({super.key, required this.actions, this.columns = 4});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 2.4,
      children: actions
          .map((a) => InfoCard(
                enableHover: true,
                onTap: a.onTap,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Icon(a.icon, size: 18, color: a.color ?? AppColors.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        a.label,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelLg(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
