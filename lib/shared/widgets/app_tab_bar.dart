import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Underline-style tab bar matching the design system (no Material default
/// ripple-heavy look) — wraps [TabBar] with our tokens.
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> tabs;

  const AppTabBar({super.key, required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.primary,
      indicatorWeight: 2.5,
      labelColor: AppColors.primary,
      unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      labelStyle: AppTextStyles.labelLg(AppColors.primary),
      unselectedLabelStyle: AppTextStyles.labelMd(isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
      dividerColor: isDark ? AppColors.borderDark : AppColors.border,
      tabs: tabs.map((t) => Tab(text: t, height: 44)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
