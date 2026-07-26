import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class DepartmentListScreen extends StatelessWidget {
  const DepartmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isDesktop(context) ? 3 : (Responsive.isTablet(context) ? 2 : 1);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Departments', subtitle: '${mockDepartments.length} departments across the institution'),
            GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
              childAspectRatio: 1.7,
              children: [
                for (final dept in mockDepartments)
                  InfoCard(
                    enableHover: true,
                    onTap: () => context.push('/admin/departments/${dept.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                              alignment: Alignment.center,
                              child: Text(dept.code.substring(0, 2), style: AppTextStyles.labelLg(AppColors.primary)),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dept.name, style: AppTextStyles.h3(_primary(context)), overflow: TextOverflow.ellipsis),
                                  Text(dept.headOfDepartment, style: AppTextStyles.caption(_secondary(context)), overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _MiniStat(label: 'Students', value: '${dept.studentCount}'),
                            _MiniStat(label: 'Faculty', value: '${dept.facultyCount}'),
                            _MiniStat(label: 'Subjects', value: '${dept.subjectCount}'),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  Color _primary(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
  Color _secondary(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? AppColors.textSecondaryDark : AppColors.textSecondary;
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
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
