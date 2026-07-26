import 'package:flutter/material.dart';
import '../../models/notification_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'time_ago.dart';

/// A single notification / announcement row.
class NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback? onTap;

  const NotificationTile({super.key, required this.item, this.onTap});

  IconData get _icon {
    switch (item.type) {
      case NotificationType.success:
        return Icons.check_circle_rounded;
      case NotificationType.warning:
        return Icons.warning_rounded;
      case NotificationType.error:
        return Icons.error_rounded;
      case NotificationType.info:
        return Icons.info_rounded;
    }
  }

  Color get _color {
    switch (item.type) {
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.error:
        return AppColors.error;
      case NotificationType.info:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          color: item.read ? Colors.transparent : _color.withValues(alpha: 0.04),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: _color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(_icon, size: 17, color: _color),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(item.title, style: AppTextStyles.labelLg(primaryText))),
                      Text(timeAgo(item.time), style: AppTextStyles.caption(secondaryText)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(item.message, style: AppTextStyles.bodySm(secondaryText)),
                ],
              ),
            ),
            if (!item.read) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
