import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'custom_dialog.dart';

/// Convenience wrapper around [showCustomDialog] for destructive / binary
/// confirmations (delete, sign out, discard changes…).
Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool isDestructive = false,
}) async {
  final result = await showCustomDialog<bool>(
    context: context,
    title: title,
    message: message,
    icon: isDestructive ? Icons.warning_amber_rounded : Icons.help_outline_rounded,
    iconColor: isDestructive ? AppColors.error : AppColors.primary,
    primaryActionLabel: confirmLabel,
    secondaryActionLabel: cancelLabel,
    onPrimaryAction: () {},
  );
  return result ?? false;
}
