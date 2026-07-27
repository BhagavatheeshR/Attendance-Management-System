import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_state.dart';
import '../../../core/responsive.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final app = AppStateScope.of(context);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Profile & Settings'),
            ProfileCard(
              initials: 'AD',
              name: app.displayName,
              subtitle: 'System Administrator · Attence University',
            ),
            const SizedBox(height: AppSpacing.lg),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferences', style: AppTextStyles.h2(primaryText)),
                  const SizedBox(height: AppSpacing.sm),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Dark mode', style: AppTextStyles.bodyMd(primaryText)),
                    subtitle: Text('Switch between light and dark theme', style: AppTextStyles.bodySm(secondaryText)),
                    value: app.themeMode == ThemeMode.dark,
                    onChanged: (_) => app.toggleTheme(),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Email notifications', style: AppTextStyles.bodyMd(primaryText)),
                    subtitle: Text('Weekly digest and low-attendance alerts', style: AppTextStyles.bodySm(secondaryText)),
                    value: true,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account', style: AppTextStyles.h2(primaryText)),
                  const SizedBox(height: AppSpacing.sm),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.mail_outline_rounded),
                    title: Text('bhagavatheeshs@gmail.com', style: AppTextStyles.bodyMd(primaryText)),
                    subtitle: Text('Primary email', style: AppTextStyles.bodySm(secondaryText)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.lock_outline_rounded),
                    title: Text('Change password', style: AppTextStyles.bodyMd(primaryText)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
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
                  message: 'You will need to sign in again to access the admin portal.',
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
