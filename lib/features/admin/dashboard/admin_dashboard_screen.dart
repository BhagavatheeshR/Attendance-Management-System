import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../mock/reports.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';
import '../faculty/add_faculty_sheet.dart';
import '../students/add_student_sheet.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final columns = Responsive.gridColumns(context);
    final isDesktop = Responsive.isDesktop(context);

    return LoadingGate(
      skeleton: _DashboardSkeleton(columns: columns),
      child: SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning, Administrator', style: AppTextStyles.displaySm(primaryText)),
            const SizedBox(height: 4),
            Text("Here's what's happening across your institution today.",
                style: AppTextStyles.bodyMd(secondaryText)),
            const SizedBox(height: AppSpacing.xl),
            GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
              childAspectRatio: 1.3,
              children: [
                StatCard(
                  label: "Today's Attendance",
                  value: '$todaysOverallAttendance%',
                  icon: Icons.fact_check_rounded,
                  accentColor: AppColors.success,
                  trendLabel: '1.2%',
                  trend: StatTrend.up,
                ),
                StatCard(
                  label: 'Students',
                  value: _formatCount(totalStudents),
                  icon: Icons.school_rounded,
                  accentColor: AppColors.primary,
                  onTap: () => context.go('/admin/students'),
                ),
                StatCard(
                  label: 'Faculty',
                  value: _formatCount(totalFaculty),
                  icon: Icons.badge_rounded,
                  accentColor: const Color(0xFF9333EA),
                  onTap: () => context.go('/admin/faculty'),
                ),
                StatCard(
                  label: 'Departments',
                  value: '$totalDepartments',
                  icon: Icons.account_balance_rounded,
                  accentColor: AppColors.info,
                  onTap: () => context.go('/admin/departments'),
                ),
                StatCard(
                  label: 'Active Classes',
                  value: '$activeClasses',
                  icon: Icons.meeting_room_rounded,
                  accentColor: AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: 'Quick Actions'),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                _QuickAction(
                  icon: Icons.person_add_alt_1_rounded,
                  label: 'Add Student',
                  onTap: () => showAddStudentSheet(context),
                ),
                _QuickAction(
                  icon: Icons.badge_outlined,
                  label: 'Add Faculty',
                  onTap: () => showAddFacultySheet(context),
                ),
                _QuickAction(
                  icon: Icons.calendar_month_outlined,
                  label: 'Create Timetable',
                  onTap: () => context.go('/admin/timetable'),
                ),
                _QuickAction(
                  icon: Icons.bar_chart_rounded,
                  label: 'Attendance Report',
                  onTap: () => context.go('/admin/reports'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            isDesktop
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _AttendanceTrendChart()),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(flex: 2, child: _UpcomingEventsCard()),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      _AttendanceTrendChart(),
                      const SizedBox(height: AppSpacing.lg),
                      _UpcomingEventsCard(),
                    ],
                  ),
            const SizedBox(height: AppSpacing.lg),
            _RecentActivityCard(),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
      ),
    );
  }

  String _formatCount(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i != 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return buffer.toString();
  }
}

class _DashboardSkeleton extends StatelessWidget {
  final int columns;
  const _DashboardSkeleton({required this.columns});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingSkeleton(width: 240, height: 26),
          const SizedBox(height: AppSpacing.sm),
          const LoadingSkeleton(width: 320, height: 14),
          const SizedBox(height: AppSpacing.xl),
          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.lg,
            mainAxisSpacing: AppSpacing.lg,
            childAspectRatio: 1.5,
            children: List.generate(5, (_) => const SkeletonStatCard()),
          ),
          const SizedBox(height: AppSpacing.xl),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(4, (_) => const SkeletonListTile()),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InfoCard(
      enableHover: true,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTextStyles.labelLg(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _AttendanceTrendChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return ChartCard(
      title: 'Attendance Trend',
      subtitle: 'Last 6 months, institution-wide',
      child: LineChart(
        LineChartData(
          minY: 85,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                interval: 5,
                getTitlesWidget: (v, meta) => Text('${v.toInt()}%', style: AppTextStyles.caption(secondaryText)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, meta) {
                  final i = v.toInt();
                  if (i < 0 || i >= monthlyAttendanceTrend.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(monthlyAttendanceTrend[i].label, style: AppTextStyles.caption(secondaryText)),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < monthlyAttendanceTrend.length; i++)
                  FlSpot(i.toDouble(), monthlyAttendanceTrend[i].percent),
              ],
              isCurved: true,
              color: AppColors.primary,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary.withValues(alpha: 0.16), AppColors.primary.withValues(alpha: 0.0)],
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => isDark ? AppColors.cardDark : AppColors.textPrimary,
              getTooltipItems: (spots) => spots
                  .map((s) => LineTooltipItem('${s.y.toStringAsFixed(1)}%', AppTextStyles.labelMd(Colors.white)))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _UpcomingEventsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events', style: AppTextStyles.h2(primaryText)),
          const SizedBox(height: AppSpacing.md),
          for (final event in upcomingEvents.take(5)) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  alignment: Alignment.center,
                  child: Text('${event.date.day}', style: AppTextStyles.labelLg(AppColors.primary)),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: AppTextStyles.labelLg(primaryText)),
                      const SizedBox(height: 2),
                      Text('${event.location} · ${event.category}', style: AppTextStyles.bodySm(secondaryText)),
                    ],
                  ),
                ),
              ],
            ),
            if (event != upcomingEvents.take(5).last) const Divider(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    const iconMap = {
      'person_add': Icons.person_add_alt_1_rounded,
      'description': Icons.description_rounded,
      'event_note': Icons.event_note_rounded,
      'badge': Icons.badge_rounded,
      'warning': Icons.warning_rounded,
      'check_circle': Icons.check_circle_rounded,
    };

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.h2(primaryText)),
          const SizedBox(height: AppSpacing.md),
          for (final activity in recentActivity) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(color: AppColors.hover, shape: BoxShape.circle),
                  child: Icon(iconMap[activity.icon] ?? Icons.circle_notifications_rounded, size: 17, color: secondaryText),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.title, style: AppTextStyles.labelLg(primaryText)),
                      const SizedBox(height: 2),
                      Text(activity.subtitle, style: AppTextStyles.bodySm(secondaryText)),
                    ],
                  ),
                ),
                Text(timeAgo(activity.time), style: AppTextStyles.caption(secondaryText)),
              ],
            ),
            if (activity != recentActivity.last) const Divider(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }
}
