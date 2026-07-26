import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'glass_container.dart';
import 'profile_avatar.dart';

/// The reusable profile header — glass surface, avatar, name, subtitle,
/// optional trailing action. Used at the top of every Profile screen.
class ProfileCard extends StatelessWidget {
  final String initials;
  final String name;
  final String subtitle;
  final Widget? trailing;

  const ProfileCard({
    super.key,
    required this.initials,
    required this.name,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GlassContainer(
      child: Row(
        children: [
          ProfileAvatar(initials: initials, size: 56, showStatusDot: true),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.h1(primaryText)),
                Text(subtitle, style: AppTextStyles.bodySm(secondaryText)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
