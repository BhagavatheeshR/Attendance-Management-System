import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../mock/students.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class StudentDetailScreen extends StatelessWidget {
  final String studentId;
  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final student = studentById(studentId) ?? featuredStudent;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        title: const Text('Student Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: Responsive.pagePadding(context),
        child: Responsive.centered(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatar(initials: student.initials, size: 64, showStatusDot: true),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: AppTextStyles.h1(primaryText)),
                          const SizedBox(height: 4),
                          Text('${student.rollNumber} · ${student.department}', style: AppTextStyles.bodySm(secondaryText)),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
                            InfoChip(icon: Icons.school_outlined, label: 'Year ${student.year}'),
                            StatusBadge(label: student.status),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GridView.count(
                crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppSpacing.lg,
                mainAxisSpacing: AppSpacing.lg,
                childAspectRatio: Responsive.isMobile(context) ? 3.4 : 3.6,
                children: [
                  AttendanceCard(percent: student.attendancePercent, subtitle: 'Overall this semester'),
                  InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact', style: AppTextStyles.h3(primaryText)),
                        const SizedBox(height: AppSpacing.sm),
                        _ContactRow(icon: Icons.mail_outline_rounded, label: student.email),
                        const SizedBox(height: 6),
                        _ContactRow(icon: Icons.phone_outlined, label: student.phone),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Attendance', style: AppTextStyles.h2(primaryText)),
                    const SizedBox(height: AppSpacing.md),
                    for (final record in currentStudentAttendanceHistory.take(6)) ...[
                      Row(
                        children: [
                          Expanded(child: Text(record.subject, style: AppTextStyles.bodyMd(primaryText))),
                          Text('${record.date.day}/${record.date.month}', style: AppTextStyles.bodySm(secondaryText)),
                          const SizedBox(width: AppSpacing.md),
                          StatusBadge(label: record.status.label),
                        ],
                      ),
                      if (record != currentStudentAttendanceHistory.take(6).last) const Divider(height: AppSpacing.lg),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ContactRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return Row(
      children: [
        Icon(icon, size: 16, color: secondaryText),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label, style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
