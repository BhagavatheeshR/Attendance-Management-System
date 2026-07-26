import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class AppDataColumn {
  final String label;
  final int flex;
  final Alignment alignment;

  const AppDataColumn({required this.label, this.flex = 1, this.alignment = Alignment.centerLeft});
}

/// A single data row. [cells] length must match the table's column count.
class AppDataRow {
  final List<Widget> cells;
  final VoidCallback? onTap;

  const AppDataRow({required this.cells, this.onTap});
}

/// Lightweight, styled data table — no row hover elevation, no shadows,
/// matches the "never animate tables" rule from the design spec.
/// Horizontally scrollable on narrow screens via [minWidth].
class AppDataTable extends StatelessWidget {
  final List<AppDataColumn> columns;
  final List<AppDataRow> rows;
  final double minWidth;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.minWidth = 720,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.borderDark : AppColors.border;
    final headerText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final cardColor = isDark ? AppColors.cardDark : AppColors.card;

    return LayoutBuilder(
      builder: (context, constraints) {
        final table = Container(
          constraints: BoxConstraints(minWidth: constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: borderColor)),
                ),
                child: Row(
                  children: columns
                      .map((c) => Expanded(
                            flex: c.flex,
                            child: Align(
                              alignment: c.alignment,
                              child: Text(c.label.toUpperCase(), style: AppTextStyles.overline(headerText)),
                            ),
                          ))
                      .toList(),
                ),
              ),
              for (int i = 0; i < rows.length; i++)
                InkWell(
                  onTap: rows[i].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                    decoration: BoxDecoration(
                      border: i == rows.length - 1
                          ? null
                          : Border(bottom: BorderSide(color: borderColor.withValues(alpha: 0.6))),
                    ),
                    child: Row(
                      children: [
                        for (int j = 0; j < columns.length; j++)
                          Expanded(
                            flex: columns[j].flex,
                            child: Align(alignment: columns[j].alignment, child: rows[i].cells[j]),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: constraints.maxWidth < minWidth ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: table,
        );
      },
    );
  }
}
