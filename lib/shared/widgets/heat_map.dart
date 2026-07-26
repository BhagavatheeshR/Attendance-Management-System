import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Generic rows x columns heat map — e.g. department (rows) x weekday
/// (columns) attendance intensity. [values] must be rowLabels.length x
/// columnLabels.length, each 0-100.
class HeatMap extends StatelessWidget {
  final List<String> rowLabels;
  final List<String> columnLabels;
  final List<List<double>> values;
  final Color baseColor;

  const HeatMap({
    super.key,
    required this.rowLabels,
    required this.columnLabels,
    required this.values,
    this.baseColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 72),
            for (final c in columnLabels) Expanded(child: Center(child: Text(c, style: AppTextStyles.caption(secondaryText)))),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        for (int r = 0; r < rowLabels.length; r++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                SizedBox(width: 72, child: Text(rowLabels[r], style: AppTextStyles.bodySm(primaryText), overflow: TextOverflow.ellipsis)),
                for (int c = 0; c < columnLabels.length; c++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: AspectRatio(
                        aspectRatio: 1.4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: baseColor.withValues(alpha: (values[r][c] / 100).clamp(0.08, 1)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            values[r][c].toStringAsFixed(0),
                            style: AppTextStyles.caption(values[r][c] > 55 ? Colors.white : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
