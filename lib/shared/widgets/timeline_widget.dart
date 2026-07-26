import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'time_ago.dart';

class TimelineEntry {
  final String title;
  final String subtitle;
  final DateTime time;
  final IconData icon;
  final Color? color;

  const TimelineEntry({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    this.color,
  });
}

/// Vertical connected-dot timeline — used for activity feeds and session
/// histories where the chronological connection between events matters.
class TimelineWidget extends StatelessWidget {
  final List<TimelineEntry> entries;

  const TimelineWidget({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final lineColor = isDark ? AppColors.borderDark : AppColors.border;

    return Column(
      children: [
        for (int i = 0; i < entries.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: entries[i].color ?? AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (i != entries.length - 1) Expanded(child: Container(width: 1.5, color: lineColor)),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entries[i].title, style: AppTextStyles.labelLg(primaryText)),
                              const SizedBox(height: 2),
                              Text(entries[i].subtitle, style: AppTextStyles.bodySm(secondaryText)),
                            ],
                          ),
                        ),
                        Text(timeAgo(entries[i].time), style: AppTextStyles.caption(secondaryText)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
