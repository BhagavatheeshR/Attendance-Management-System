import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/reports.dart';
import '../../../mock/students.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final isDesktop = Responsive.isDesktop(context);
    final today = todayName() == 'Sunday' ? 'Monday' : todayName();
    final classes = timetableForDay(departmentId: 'dept-cse', year: 'III', day: today);
    final currentClass = classes.isNotEmpty ? classes.first : null;
    final nextClass = classes.length > 1 ? classes[1] : null;

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, ${currentStudent.name.split(' ').first}', style: AppTextStyles.displaySm(primaryText)),
            const SizedBox(height: 4),
            Text('${currentStudent.department} · Year ${currentStudent.year} · ${currentStudent.rollNumber}', style: AppTextStyles.bodyMd(secondaryText)),
            const SizedBox(height: AppSpacing.xl),
            isDesktop
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _TodaysClassesCard(classes: classes, currentSubject: currentClass?.subject)),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              AttendanceCard(percent: currentStudent.attendancePercent, subtitle: 'Overall this semester'),
                              const SizedBox(height: AppSpacing.lg),
                              _NextClassCard(nextClass: nextClass),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      _TodaysClassesCard(classes: classes, currentSubject: currentClass?.subject),
                      const SizedBox(height: AppSpacing.lg),
                      AttendanceCard(percent: currentStudent.attendancePercent, subtitle: 'Overall this semester'),
                      const SizedBox(height: AppSpacing.lg),
                      _NextClassCard(nextClass: nextClass),
                    ],
                  ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              title: 'Announcements',
              action: TextButton(onPressed: () => context.go('/student/announcements'), child: const Text('View all')),
            ),
            InfoCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [for (final n in studentAnnouncements.take(3)) NotificationTile(item: n)],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _ShortcutCard(
                    icon: Icons.fact_check_outlined,
                    label: 'Attendance History',
                    color: AppColors.success,
                    onTap: () => context.go('/student/attendance'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _ShortcutCard(
                    icon: Icons.calendar_month_outlined,
                    label: 'Timetable',
                    color: AppColors.primary,
                    onTap: () => context.go('/student/timetable'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _TodaysClassesCard extends StatelessWidget {
  final List<dynamic> classes;
  final String? currentSubject;
  const _TodaysClassesCard({required this.classes, required this.currentSubject});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Classes", style: AppTextStyles.h2(primaryText)),
              if (currentSubject != null) StatusBadge(label: 'Now: $currentSubject', color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (classes.isEmpty)
            const EmptyState(icon: Icons.event_available_rounded, title: 'No classes today', message: 'Enjoy your day off!')
          else
            for (final c in classes) ...[
              Row(
                children: [
                  SizedBox(width: 64, child: Text(c.startTime, style: AppTextStyles.labelLg(AppColors.primary))),
                  Container(width: 3, height: 32, color: AppColors.primary.withValues(alpha: 0.3)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.subject, style: AppTextStyles.labelLg(primaryText)),
                        Text('${c.facultyName} · ${c.room}', style: AppTextStyles.caption(secondaryText)),
                      ],
                    ),
                  ),
                ],
              ),
              if (c != classes.last) const Divider(height: AppSpacing.lg),
            ],
        ],
      ),
    );
  }
}

class _NextClassCard extends StatelessWidget {
  final dynamic nextClass;
  const _NextClassCard({required this.nextClass});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.warningSurface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            alignment: Alignment.center,
            child: const Icon(Icons.schedule_rounded, color: AppColors.warning),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next Class', style: AppTextStyles.bodySm(secondaryText)),
                Text(nextClass?.subject ?? 'No more classes today', style: AppTextStyles.h3(primaryText)),
                if (nextClass != null) Text('${nextClass.startTime} · ${nextClass.room}', style: AppTextStyles.caption(secondaryText)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShortcutCard({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InfoCard(
      enableHover: true,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.labelLg(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
