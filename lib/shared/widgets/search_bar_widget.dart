import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Standard search input used at the top of every list screen.
/// Named `AppSearchBar` to avoid clashing with Material's SearchBar.
class AppSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Widget? trailing;

  const AppSearchBar({
    super.key,
    this.hint = 'Search…',
    this.onChanged,
    this.controller,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.borderDark : AppColors.border;
    final fillColor = isDark ? AppColors.cardDark : AppColors.card;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final iconColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 19, color: iconColor),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.bodyMd(textColor),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMd(iconColor),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
