import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  const BreadcrumbItem({required this.label, this.onTap});
}

/// Desktop/web breadcrumb trail shown under the top app bar on deep
/// screens (e.g. Departments › Computer Science › Faculty).
class Breadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  const Breadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i != 0) ...[
            const SizedBox(width: 6),
            Icon(Icons.chevron_right_rounded, size: 14, color: secondaryText),
            const SizedBox(width: 6),
          ],
          InkWell(
            onTap: items[i].onTap,
            child: Text(
              items[i].label,
              style: i == items.length - 1 ? AppTextStyles.labelMd(primaryText) : AppTextStyles.bodySm(secondaryText),
            ),
          ),
        ],
      ],
    );
  }
}
