import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class FacultyReportsScreen extends StatelessWidget {
  const FacultyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'My Reports',
              subtitle: 'Attendance performance across your classes',
              action: SecondaryButton(
                label: 'Export CSV',
                icon: Icons.file_download_outlined,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preparing export…'))),
              ),
            ),
            ChartCard(
              title: 'Weekly Attendance',
              subtitle: 'Across all your sections',
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 20,
                      getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 34,
                        getTitlesWidget: (v, m) => Text('${v.toInt()}', style: AppTextStyles.caption(secondaryText)))),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= weeklyAttendanceTrend.length) return const SizedBox.shrink();
                      return Padding(padding: const EdgeInsets.only(top: 6), child: Text(weeklyAttendanceTrend[i].label, style: AppTextStyles.caption(secondaryText)));
                    })),
                  ),
                  barGroups: [
                    for (int i = 0; i < weeklyAttendanceTrend.length; i++)
                      BarChartGroupData(x: i, barRods: [
                        BarChartRodData(toY: weeklyAttendanceTrend[i].percent, color: AppColors.primary, width: 18, borderRadius: BorderRadius.circular(4)),
                      ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ChartCard(
              title: 'Subject Analytics',
              subtitle: 'Attendance by subject you teach',
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 20,
                      getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 34,
                        getTitlesWidget: (v, m) => Text('${v.toInt()}', style: AppTextStyles.caption(secondaryText)))),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= subjectAttendanceAnalytics.length) return const SizedBox.shrink();
                      final label = subjectAttendanceAnalytics[i].department;
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(label.length > 6 ? label.substring(0, 6) : label, style: AppTextStyles.caption(secondaryText)),
                      );
                    })),
                  ),
                  barGroups: [
                    for (int i = 0; i < subjectAttendanceAnalytics.length; i++)
                      BarChartGroupData(x: i, barRods: [
                        BarChartRodData(toY: subjectAttendanceAnalytics[i].percent, color: AppColors.success, width: 18, borderRadius: BorderRadius.circular(4)),
                      ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}
