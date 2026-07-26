import 'package:flutter/material.dart';
import '../../models/department.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';

/// The one reusable card for a department summary tile.
class DepartmentCard extends StatelessWidget {
  final Department department;
  final VoidCallback? onTap;

  const DepartmentCard({super.key, required this.department, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      enableHover: true,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                alignment: Alignment.center,
                child: Text(department.code.substring(0, 2), style: AppTextStyles.labelLg(AppColors.primary)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(department.name, style: AppTextStyles.h3(primaryText), overflow: TextOverflow.ellipsis),
                    Text(department.headOfDepartment, style: AppTextStyles.caption(secondaryText), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stat(context, 'Students', '${department.studentCount}'),
              _stat(context, 'Faculty', '${department.facultyCount}'),
              _stat(context, 'Subjects', '${department.subjectCount}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTextStyles.h3(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
        Text(label, style: AppTextStyles.caption(isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
      ],
    );
  }
}
