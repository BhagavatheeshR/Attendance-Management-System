import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../mock/faculty.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class FacultyDashboardScreen extends StatelessWidget {
  const FacultyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final isDesktop = Responsive.isDesktop(context);
    final today = todayName() == 'Sunday' ? 'Monday' : todayName();
    final todaysClasses = timetableForDay(departmentId: 'dept-cse', year: 'III', day: today);
    final present = currentSessionRoster.length - currentSessionAbsentIds.length;
    final absent = currentSessionAbsentIds.length;

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${currentFaculty.name}', style: AppTextStyles.displaySm(primaryText)),
            const SizedBox(height: 4),
            Text('${currentFaculty.department} · ${currentFaculty.designation}', style: AppTextStyles.bodyMd(secondaryText)),
            const SizedBox(height: AppSpacing.xl),
            isDesktop
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _TodaysClassesCard(classes: todaysClasses)),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(flex: 2, child: _CurrentSessionCard(present: present, absent: absent)),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      _TodaysClassesCard(classes: todaysClasses),
                      const SizedBox(height: AppSpacing.lg),
                      _CurrentSessionCard(present: present, absent: absent),
                    ],
                  ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _ShortcutCard(
                    icon: Icons.bar_chart_rounded,
                    label: 'Reports',
                    color: AppColors.primary,
                    onTap: () => context.go('/faculty/reports'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _ShortcutCard(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    color: AppColors.warning,
                    onTap: () => context.go('/faculty/notifications'),
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
  const _TodaysClassesCard({required this.classes});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Classes", style: AppTextStyles.h2(primaryText)),
          const SizedBox(height: AppSpacing.md),
          if (classes.isEmpty)
            const EmptyState(icon: Icons.event_available_rounded, title: 'No classes today', message: 'Enjoy your day off!')
          else
            for (final c in classes) ...[
              Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: Text(c.startTime, style: AppTextStyles.labelLg(AppColors.primary)),
                  ),
                  Container(width: 3, height: 32, color: AppColors.primary.withValues(alpha: 0.3)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.subject, style: AppTextStyles.labelLg(primaryText)),
                        Text(c.room, style: AppTextStyles.caption(secondaryText)),
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

class _CurrentSessionCard extends StatelessWidget {
  final int present;
  final int absent;
  const _CurrentSessionCard({required this.present, required this.absent});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final total = present + absent;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Session', style: AppTextStyles.h2(primaryText)),
          const SizedBox(height: 2),
          Text('Database Systems · $total Students', style: AppTextStyles.bodySm(secondaryText)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$present', style: AppTextStyles.statValue(AppColors.success)),
                    Text('Present', style: AppTextStyles.bodySm(secondaryText)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$absent', style: AppTextStyles.statValue(AppColors.error)),
                    Text('Absent', style: AppTextStyles.bodySm(secondaryText)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'Start Attendance',
            icon: Icons.fact_check_rounded,
            fullWidth: true,
            onPressed: () => context.push('/faculty/attendance/session/cse3-database-systems'),
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
