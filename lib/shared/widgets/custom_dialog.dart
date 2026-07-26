import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'glass_container.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

/// Generic modal dialog with a frosted-glass surface, title, body and
/// up to two actions. Use [showCustomDialog] to present it.
class CustomDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;
  final String primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final IconData? icon;
  final Color? iconColor;

  const CustomDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.primaryActionLabel = 'Continue',
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: GlassContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(icon, color: iconColor ?? AppColors.primary),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              Text(title, style: AppTextStyles.h1(primaryText)),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(message!, style: AppTextStyles.bodyMd(secondaryText)),
              ],
              if (content != null) ...[
                const SizedBox(height: AppSpacing.md),
                content!,
              ],
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (secondaryActionLabel != null)
                    SecondaryButton(
                      label: secondaryActionLabel!,
                      onPressed: onSecondaryAction ?? () => Navigator.of(context).pop(false),
                    ),
                  if (secondaryActionLabel != null) const SizedBox(width: AppSpacing.sm),
                  PrimaryButton(
                    label: primaryActionLabel,
                    onPressed: onPrimaryAction ?? () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  String? message,
  Widget? content,
  String primaryActionLabel = 'Continue',
  VoidCallback? onPrimaryAction,
  String? secondaryActionLabel,
  VoidCallback? onSecondaryAction,
  IconData? icon,
  Color? iconColor,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: title,
    barrierColor: Colors.black.withValues(alpha: 0.25),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) => CustomDialog(
      title: title,
      message: message,
      content: content,
      primaryActionLabel: primaryActionLabel,
      onPrimaryAction: onPrimaryAction,
      secondaryActionLabel: secondaryActionLabel,
      onSecondaryAction: onSecondaryAction,
      icon: icon,
      iconColor: iconColor,
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: ScaleTransition(
        scale: Tween(begin: 0.96, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      ),
    ),
  );
}
