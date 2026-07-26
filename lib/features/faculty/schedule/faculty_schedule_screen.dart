import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class FacultyScheduleScreen extends StatefulWidget {
  const FacultyScheduleScreen({super.key});

  @override
  State<FacultyScheduleScreen> createState() => _FacultyScheduleScreenState();
}

class _FacultyScheduleScreenState extends State<FacultyScheduleScreen> {
  String _day = todayName() == 'Sunday' ? 'Monday' : todayName();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final entries = timetableForDay(departmentId: 'dept-cse', year: 'III', day: _day);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'My Schedule', subtitle: 'Weekly teaching timetable'),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final d in weekDays) ...[
                    AppFilterChip(label: d.substring(0, 3), selected: _day == d, onSelected: (_) => setState(() => _day = d)),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (entries.isEmpty)
              const EmptyState(icon: Icons.event_busy_rounded, title: 'No classes', message: 'No classes scheduled for this day.')
            else
              for (final entry in entries) ...[
                InfoCard(
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
                        child: Text(entry.startTime, style: AppTextStyles.labelLg(primaryText)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.subject, style: AppTextStyles.h3(primaryText)),
                            Text(entry.subjectCode, style: AppTextStyles.bodySm(secondaryText)),
                          ],
                        ),
                      ),
                      InfoChip(icon: Icons.meeting_room_outlined, label: entry.room),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}
