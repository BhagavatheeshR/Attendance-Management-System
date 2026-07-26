import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';

/// Circular attendance-percentage indicator with label — used on the
/// Student dashboard ("Attendance 92%") and profile screens.
class AttendanceCard extends StatelessWidget {
  final double percent;
  final String label;
  final String? subtitle;

  const AttendanceCard({
    super.key,
    required this.percent,
    this.label = 'Attendance',
    this.subtitle,
  });

  Color get _color {
    if (percent >= 90) return AppColors.success;
    if (percent >= 75) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: percent / 100),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => CircularProgressIndicator(
                    value: value,
                    strokeWidth: 6,
                    backgroundColor: isDark ? AppColors.hoverDark : AppColors.hover,
                    valueColor: AlwaysStoppedAnimation(_color),
                  ),
                ),
                Text('${percent.toStringAsFixed(0)}%', style: AppTextStyles.statValueSm(primaryText)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.h3(primaryText)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.bodySm(secondaryText)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
