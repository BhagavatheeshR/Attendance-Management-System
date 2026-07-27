import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_state.dart';
import '../../../core/responsive.dart';
import '../../../mock/faculty.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class FacultyProfileScreen extends StatelessWidget {
  const FacultyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final app = AppStateScope.of(context);
    final faculty = currentFaculty;

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Profile'),
            ProfileCard(
              initials: faculty.initials,
              name: faculty.name,
              subtitle: '${faculty.designation} · ${faculty.department}',
            ),
            const SizedBox(height: AppSpacing.lg),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Details', style: AppTextStyles.h2(primaryText)),
                  const SizedBox(height: AppSpacing.sm),
                  _Row(label: 'Employee ID', value: faculty.employeeId),
                  _Row(label: 'Experience', value: '${faculty.experienceYears} Years'),
                  _Row(label: 'Email', value: faculty.email),
                  _Row(label: 'Phone', value: faculty.phone),
                  _Row(label: 'Subjects', value: faculty.subjects.join(', ')),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            InfoCard(
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Dark mode', style: AppTextStyles.bodyMd(primaryText)),
                value: app.themeMode == ThemeMode.dark,
                onChanged: (_) => app.toggleTheme(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SecondaryButton(
              label: 'Sign out',
              icon: Icons.logout_rounded,
              onPressed: () async {
                final confirmed = await showConfirmationDialog(
                  context: context,
                  title: 'Sign out?',
                  message: 'You will need to sign in again to access the faculty portal.',
                  confirmLabel: 'Sign out',
                  isDestructive: true,
                );
                if (confirmed && context.mounted) {
                  app.logout();
                  context.go('/login');
                }
              },
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: AppTextStyles.bodySm(secondaryText))),
          Expanded(child: Text(value, style: AppTextStyles.bodyMd(primaryText))),
        ],
      ),
    );
  }
}
