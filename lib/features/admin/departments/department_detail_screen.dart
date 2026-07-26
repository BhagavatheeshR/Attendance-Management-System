import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../mock/faculty.dart';
import '../../../mock/students.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class DepartmentDetailScreen extends StatelessWidget {
  final String departmentId;
  const DepartmentDetailScreen({super.key, required this.departmentId});

  @override
  Widget build(BuildContext context) {
    final dept = departmentById(departmentId);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final students = studentsByDepartment(dept.id);
    final faculty = facultyByDepartment(dept.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        title: Text(dept.name),
      ),
      body: SingleChildScrollView(
        padding: Responsive.pagePadding(context),
        child: Responsive.centered(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(dept.name, style: AppTextStyles.h1(primaryText))),
                        InfoChip(icon: Icons.badge_outlined, label: dept.code),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Head of Department: ${dept.headOfDepartment}', style: AppTextStyles.bodySm(secondaryText)),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        _StatBlock(label: 'Students', value: '${dept.studentCount}'),
                        _StatBlock(label: 'Faculty', value: '${dept.facultyCount}'),
                        _StatBlock(label: 'Subjects', value: '${dept.subjectCount}'),
                        _StatBlock(label: 'Attendance', value: '${dept.averageAttendance.toStringAsFixed(1)}%'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SectionHeader(title: 'Faculty in this Department', subtitle: '${faculty.length} shown'),
              for (final f in faculty) ...[
                InfoCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  onTap: () => context.push('/admin/faculty/${f.id}'),
                  enableHover: true,
                  child: Row(
                    children: [
                      ProfileAvatar(initials: f.initials, size: 36),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.name, style: AppTextStyles.labelLg(primaryText)),
                            Text(f.designation, style: AppTextStyles.bodySm(secondaryText)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: secondaryText),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.md),
              SectionHeader(title: 'Students in this Department', subtitle: '${students.length} shown'),
              for (final s in students.take(10)) ...[
                InfoCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  onTap: () => context.push('/admin/students/${s.id}'),
                  enableHover: true,
                  child: Row(
                    children: [
                      ProfileAvatar(initials: s.initials, size: 36),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.name, style: AppTextStyles.labelLg(primaryText)),
                            Text('${s.rollNumber} · Year ${s.year}', style: AppTextStyles.bodySm(secondaryText)),
                          ],
                        ),
                      ),
                      Text('${s.attendancePercent.toStringAsFixed(1)}%', style: AppTextStyles.labelMd(secondaryText)),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  const _StatBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTextStyles.h1(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
          Text(label, style: AppTextStyles.bodySm(isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
