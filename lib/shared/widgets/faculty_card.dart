import 'package:flutter/material.dart';
import '../../models/faculty.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';
import 'info_chip.dart';
import 'profile_avatar.dart';

/// The one reusable card for showing a faculty summary.
class FacultyCard extends StatelessWidget {
  final Faculty faculty;
  final VoidCallback? onTap;
  final Widget? trailing;

  const FacultyCard({super.key, required this.faculty, this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      enableHover: onTap != null,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        children: [
          ProfileAvatar(initials: faculty.initials, size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(faculty.name, style: AppTextStyles.labelLg(primaryText)),
                const SizedBox(height: 2),
                Text('${faculty.employeeId} · ${faculty.department}', style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else
            InfoChip(icon: Icons.workspace_premium_outlined, label: faculty.designation),
        ],
      ),
    );
  }
}
