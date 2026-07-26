import 'package:flutter/material.dart';
import '../../models/timetable_entry.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';
import 'info_chip.dart';

/// The one reusable card for a single timetable slot — used by Admin,
/// Faculty, and Student timetable screens alike.
class TimetableCard extends StatelessWidget {
  final TimetableEntry entry;
  final bool showFaculty;

  const TimetableCard({super.key, required this.entry, this.showFaculty = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Row(
        children: [
          Container(
            width: 4,
            height: 44,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
          ),
          const SizedBox(width: AppSpacing.lg),
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.startTime, style: AppTextStyles.labelLg(primaryText)),
                Text(entry.endTime, style: AppTextStyles.caption(secondaryText)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.subject, style: AppTextStyles.h3(primaryText)),
                const SizedBox(height: 2),
                Text(
                  showFaculty ? '${entry.subjectCode} · ${entry.facultyName}' : entry.subjectCode,
                  style: AppTextStyles.bodySm(secondaryText),
                ),
              ],
            ),
          ),
          InfoChip(icon: Icons.meeting_room_outlined, label: entry.room),
        ],
      ),
    );
  }
}
