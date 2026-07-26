import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Generic pill-style segmented control (2-4 options). Used for role
/// pickers, view toggles (List/Grid), and range pickers (Week/Month).
class SegmentedControl<T> extends StatelessWidget {
  final List<T> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T) labelBuilder;

  const SegmentedControl({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark ? AppColors.hoverDark : AppColors.hover;
    final borderColor = isDark ? AppColors.borderDark : AppColors.border;
    final thumbColor = isDark ? AppColors.cardDark : AppColors.card;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          final isSelected = option == selected;
          return GestureDetector(
            onTap: () => onChanged(option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? thumbColor : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                boxShadow: isSelected ? AppShadows.resolveLow(isDark) : null,
              ),
              child: Text(
                labelBuilder(option),
                style: AppTextStyles.labelMd(isSelected ? AppColors.primary : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
