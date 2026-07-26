import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Right-docked panel for desktop/web — used to show detail/edit content
/// without leaving the current list (e.g. a student's quick profile),
/// sliding in over the content instead of a full page navigation.
Future<T?> showSidePanel<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  double width = 420,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: title,
    barrierColor: Colors.black.withValues(alpha: 0.25),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.card,
        child: Container(
          width: width,
          height: double.infinity,
          decoration: BoxDecoration(boxShadow: AppShadows.resolveHigh(isDark)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(title, style: AppTextStyles.h1(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
                      ),
                      IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(AppSpacing.lg), child: child)),
              ],
            ),
          ),
        ),
      ),
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    ),
  );
}
