import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

/// Lets faculty pick which of today's classes to take attendance for.
class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final today = todayName() == 'Sunday' ? 'Monday' : todayName();
    final classes = timetableForDay(departmentId: 'dept-cse', year: 'III', day: today);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Take Attendance', subtitle: 'Select a class to mark attendance'),
            for (final c in classes) ...[
              InfoCard(
                enableHover: true,
                onTap: () => context.push('/faculty/attendance/session/${c.id}'),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                      alignment: Alignment.center,
                      child: Icon(Icons.menu_book_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.subject, style: AppTextStyles.h3(primaryText)),
                          const SizedBox(height: 2),
                          Text('${c.startTime} - ${c.endTime} · ${c.room}', style: AppTextStyles.bodySm(secondaryText)),
                        ],
                      ),
                    ),
                    SecondaryButton(
                      label: 'Start',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => context.push('/faculty/attendance/session/${c.id}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}
