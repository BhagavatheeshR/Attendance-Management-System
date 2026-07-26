import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class DonutSegment {
  final String label;
  final double value;
  final Color color;
  const DonutSegment({required this.label, required this.value, required this.color});
}

/// Donut chart with a centered total and a legend — set [holeRadius] to 0
/// for a full pie chart.
class DonutChart extends StatelessWidget {
  final List<DonutSegment> segments;
  final String? centerLabel;
  final double holeRadius;

  const DonutChart({super.key, required this.segments, this.centerLabel, this.holeRadius = 48});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = segments.fold<double>(0, (a, b) => a + b.value);
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: holeRadius,
                  sections: segments
                      .map((s) => PieChartSectionData(
                            value: s.value,
                            color: s.color,
                            radius: 42,
                            showTitle: false,
                          ))
                      .toList(),
                ),
              ),
              if (centerLabel != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(centerLabel!, style: AppTextStyles.h1(primaryText)),
                    Text('Total', style: AppTextStyles.caption(secondaryText)),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: segments.map((s) {
              final pct = total == 0 ? 0 : (s.value / total) * 100;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Expanded(child: Text(s.label, style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis)),
                    Text('${pct.toStringAsFixed(0)}%', style: AppTextStyles.labelMd(primaryText)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
