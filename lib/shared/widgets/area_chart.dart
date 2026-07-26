import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Filled area/line chart — thin wrapper around fl_chart's LineChart with
/// a gradient fill, so callers don't have to repeat the same FlTitlesData
/// boilerplate for every trend chart.
class AreaChart extends StatelessWidget {
  final List<String> labels;
  final List<double> values;
  final Color color;
  final double minY;
  final double maxY;

  const AreaChart({
    super.key,
    required this.labels,
    required this.values,
    this.color = AppColors.primary,
    this.minY = 0,
    this.maxY = 100,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final interval = (maxY - minY) / 5;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval == 0 ? 1 : interval,
          getDrawingHorizontalLine: (v) => FlLine(color: isDark ? AppColors.borderDark : AppColors.divider, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              interval: interval == 0 ? 1 : interval,
              getTitlesWidget: (v, m) => Text(v.toInt().toString(), style: AppTextStyles.caption(secondaryText)),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, m) {
                final i = v.toInt();
                if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                return Padding(padding: const EdgeInsets.only(top: 6), child: Text(labels[i], style: AppTextStyles.caption(secondaryText)));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [for (int i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i])],
            isCurved: true,
            color: color,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
