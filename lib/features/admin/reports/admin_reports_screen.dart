import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../models/attendance_record.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Reports & Analytics',
              subtitle: 'Institution-wide attendance and performance insights',
              action: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                    label: 'Export CSV',
                    icon: Icons.file_download_outlined,
                    onPressed: () => _exportSnack(context, 'CSV'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  PrimaryButton(
                    label: 'Export PDF',
                    icon: Icons.picture_as_pdf_outlined,
                    onPressed: () => _exportSnack(context, 'PDF'),
                  ),
                ],
              ),
            ),
            _ResponsiveChartRow(
              isDesktop: isDesktop,
              children: [
                ChartCard(title: 'Attendance Trend', subtitle: 'Last 6 months', child: _lineChart(monthlyAttendanceTrend, context)),
                ChartCard(title: 'Weekly Attendance', subtitle: 'This week', child: _barChart(
                  labels: [for (final p in weeklyAttendanceTrend) p.label],
                  values: [for (final p in weeklyAttendanceTrend) p.percent],
                  color: AppColors.success,
                  context: context,
                )),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _ResponsiveChartRow(
              isDesktop: isDesktop,
              children: [
                ChartCard(
                  title: 'Department Comparison',
                  subtitle: 'Average attendance by department',
                  height: 320,
                  child: _horizontalBarChart(departmentAttendanceComparison, context),
                ),
                ChartCard(title: 'Subject Analytics', subtitle: 'Average attendance by subject', child: _barChart(
                  labels: [for (final p in subjectAttendanceAnalytics) p.department],
                  values: [for (final p in subjectAttendanceAnalytics) p.percent],
                  color: AppColors.primary,
                  context: context,
                )),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _ResponsiveChartRow(
              isDesktop: isDesktop,
              children: [
                ChartCard(title: 'Student Growth', subtitle: 'Enrollment over 6 years', child: _growthChart(context)),
                ChartCard(title: 'Faculty Workload', subtitle: 'Avg. teaching hours / week', child: _barChart(
                  labels: [for (final p in facultyWorkload) p.department],
                  values: [for (final p in facultyWorkload) p.percent],
                  color: const Color(0xFF9333EA),
                  context: context,
                  maxY: 24,
                )),
              ],
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  void _exportSnack(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preparing $format export…')));
  }

  Widget _lineChart(List<AttendanceTrendPoint> points, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return LineChart(
      LineChartData(
        minY: 85,
        maxY: 100,
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 5,
            getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 34, interval: 5,
              getTitlesWidget: (v, m) => Text('${v.toInt()}%', style: AppTextStyles.caption(secondaryText)))),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
            final i = v.toInt();
            if (i < 0 || i >= points.length) return const SizedBox.shrink();
            return Padding(padding: const EdgeInsets.only(top: 6), child: Text(points[i].label, style: AppTextStyles.caption(secondaryText)));
          })),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].percent)],
            isCurved: true,
            color: AppColors.primary,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [AppColors.primary.withValues(alpha: 0.16), AppColors.primary.withValues(alpha: 0)])),
          ),
        ],
      ),
    );
  }

  Widget _barChart({
    required List<String> labels,
    required List<double> values,
    required Color color,
    required BuildContext context,
    double maxY = 100,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final interval = maxY / 5;
    return BarChart(
      BarChartData(
        maxY: maxY,
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: interval,
            getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 34, interval: interval,
              getTitlesWidget: (v, m) => Text('${v.toInt()}', style: AppTextStyles.caption(secondaryText)))),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
            final i = v.toInt();
            if (i < 0 || i >= labels.length) return const SizedBox.shrink();
            final label = labels[i];
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(label.length > 4 ? label.substring(0, 4) : label, style: AppTextStyles.caption(secondaryText)),
            );
          })),
        ),
        barGroups: [
          for (int i = 0; i < values.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(toY: values[i], color: color, width: 18, borderRadius: BorderRadius.circular(4)),
            ]),
        ],
      ),
    );
  }

  Widget _horizontalBarChart(List<DepartmentAttendance> points, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return ListView.separated(
      itemCount: points.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        final p = points[i];
        final pct = p.percent / 100;
        return Row(
          children: [
            SizedBox(width: 48, child: Text(p.department, style: AppTextStyles.labelMd(primaryText))),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 10,
                  backgroundColor: isDark ? AppColors.hoverDark : AppColors.hover,
                  valueColor: AlwaysStoppedAnimation(AppColors.chartSeries[i % AppColors.chartSeries.length]),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(width: 44, child: Text('${p.percent.toStringAsFixed(1)}%', style: AppTextStyles.bodySm(secondaryText))),
          ],
        );
      },
    );
  }

  Widget _growthChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return LineChart(
      LineChartData(
        minY: 9000,
        maxY: 13000,
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1000,
            getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1)),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 44, interval: 1000,
              getTitlesWidget: (v, m) => Text('${(v / 1000).toStringAsFixed(0)}k', style: AppTextStyles.caption(secondaryText)))),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
            final i = v.toInt();
            if (i < 0 || i >= studentGrowthTrend.length) return const SizedBox.shrink();
            return Padding(padding: const EdgeInsets.only(top: 6), child: Text(studentGrowthTrend[i].label, style: AppTextStyles.caption(secondaryText)));
          })),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [for (int i = 0; i < studentGrowthTrend.length; i++) FlSpot(i.toDouble(), studentGrowthTrend[i].percent)],
            isCurved: true,
            color: AppColors.success,
            barWidth: 2.5,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveChartRow extends StatelessWidget {
  final bool isDesktop;
  final List<Widget> children;
  const _ResponsiveChartRow({required this.isDesktop, required this.children});

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return Column(children: [for (final c in children) ...[c, const SizedBox(height: AppSpacing.lg)]]);
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            Expanded(child: children[i]),
            if (i != children.length - 1) const SizedBox(width: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
