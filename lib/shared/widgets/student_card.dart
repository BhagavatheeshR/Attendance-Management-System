import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';
import 'profile_avatar.dart';
import 'status_badge.dart';

/// The one reusable card for showing a student summary — list rows,
/// department detail pages, and search results all use this.
class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;
  final Widget? trailing;

  const StudentCard({super.key, required this.student, this.onTap, this.trailing});

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
          ProfileAvatar(initials: student.initials, size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.name, style: AppTextStyles.labelLg(primaryText)),
                const SizedBox(height: 2),
                Text('${student.rollNumber} · ${student.department} · Year ${student.year}',
                    style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else ...[
            Text('${student.attendancePercent.toStringAsFixed(1)}%',
                style: AppTextStyles.labelMd(
                  student.attendancePercent >= 90 ? AppColors.success : student.attendancePercent >= 75 ? AppColors.warning : AppColors.error,
                )),
            const SizedBox(width: AppSpacing.md),
            StatusBadge(label: student.status),
          ],
        ],
      ),
    );
  }
}
