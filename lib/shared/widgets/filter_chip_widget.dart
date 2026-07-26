import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Selectable filter pill (department, status, year…). Named
/// `AppFilterChip` to avoid clashing with Flutter's built-in [FilterChip].
class AppFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.borderDark : AppColors.border;
    final bg = selected
        ? AppColors.primary.withValues(alpha: 0.1)
        : (isDark ? AppColors.hoverDark : Colors.transparent);
    final fg = selected ? AppColors.primary : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary);

    return InkWell(
      onTap: onSelected == null ? null : () => onSelected!(!selected),
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(color: selected ? AppColors.primary.withValues(alpha: 0.4) : borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: 6),
            ],
            Text(label, style: AppTextStyles.labelMd(fg)),
          ],
        ),
      ),
    );
  }
}
