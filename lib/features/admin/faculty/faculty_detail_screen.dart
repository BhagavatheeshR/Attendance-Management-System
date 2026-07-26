import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/faculty.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class FacultyDetailScreen extends StatelessWidget {
  final String facultyId;
  const FacultyDetailScreen({super.key, required this.facultyId});

  @override
  Widget build(BuildContext context) {
    final faculty = facultyById(facultyId) ?? featuredFaculty;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        title: const Text('Faculty Profile'),
        actions: [IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {})],
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
                    ProfileAvatar(initials: faculty.initials, size: 64, showStatusDot: true),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(faculty.name, style: AppTextStyles.h1(primaryText)),
                          const SizedBox(height: 4),
                          Text('${faculty.employeeId} · ${faculty.department}', style: AppTextStyles.bodySm(secondaryText)),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
                            InfoChip(icon: Icons.workspace_premium_outlined, label: faculty.designation),
                            InfoChip(icon: Icons.timelapse_rounded, label: '${faculty.experienceYears} yrs experience'),
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
                  InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subjects Taught', style: AppTextStyles.h3(primaryText)),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [for (final s in faculty.subjects) InfoChip(icon: Icons.menu_book_outlined, label: s)],
                        ),
                      ],
                    ),
                  ),
                  InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact', style: AppTextStyles.h3(primaryText)),
                        const SizedBox(height: AppSpacing.sm),
                        Row(children: [
                          Icon(Icons.mail_outline_rounded, size: 16, color: secondaryText),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(child: Text(faculty.email, style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis)),
                        ]),
                        const SizedBox(height: 6),
                        Row(children: [
                          Icon(Icons.phone_outlined, size: 16, color: secondaryText),
                          const SizedBox(width: AppSpacing.sm),
                          Text(faculty.phone, style: AppTextStyles.bodySm(secondaryText)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
