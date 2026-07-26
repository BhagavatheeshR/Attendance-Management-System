import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../mock/students.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final records = currentStudentAttendanceHistory;

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Attendance History'),
            AttendanceCard(percent: currentStudent.attendancePercent, subtitle: 'Overall attendance this semester'),
            const SizedBox(height: AppSpacing.lg),
            ChartCard(
              title: 'Weekly Attendance',
              subtitle: 'Your attendance rate, last 6 weeks',
              child: LineChart(
                LineChartData(
                  minY: 60,
                  maxY: 100,
                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 10,
                      getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 34, interval: 10,
                        getTitlesWidget: (v, m) => Text('${v.toInt()}%', style: AppTextStyles.caption(secondaryText)))),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      return Padding(padding: const EdgeInsets.only(top: 6), child: Text('W${i + 1}', style: AppTextStyles.caption(secondaryText)));
                    })),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [FlSpot(0, 88), FlSpot(1, 92), FlSpot(2, 85), FlSpot(3, 95), FlSpot(4, 90), FlSpot(5, 92)],
                      isCurved: true,
                      color: AppColors.success,
                      barWidth: 2.5,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: 'Recent Sessions', subtitle: '${records.length} records'),
            for (final r in records) ...[
              InfoCard(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.subject, style: AppTextStyles.labelLg(primaryText)),
                          Text('${r.date.day}/${r.date.month}/${r.date.year}', style: AppTextStyles.bodySm(secondaryText)),
                        ],
                      ),
                    ),
                    StatusBadge(label: r.status.label),
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
