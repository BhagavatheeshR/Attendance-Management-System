import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../shared/widgets/profile_avatar.dart';
import 'app_state.dart';

class AppNavDestination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const AppNavDestination({required this.icon, required this.selectedIcon, required this.label});
}

/// Responsive role-shell used by Admin/Faculty/Student portals:
/// - Mobile: bottom navigation (max 4 tabs + "More")
/// - Tablet: icon-only navigation rail
/// - Desktop: collapsible extended navigation rail (sidebar) + top app bar
class AppShell extends StatefulWidget {
  final String portalLabel;
  final String userInitials;
  final List<AppNavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppShell({
    super.key,
    required this.portalLabel,
    required this.userInitials,
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.child,
    this.actions,
    this.floatingActionButton,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _sidebarExpanded = true;

  void _showMoreSheet(BuildContext context, List<int> overflowIndexes) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.cardDark : AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: overflowIndexes.map((i) {
              final d = widget.destinations[i];
              return ListTile(
                leading: Icon(d.icon),
                title: Text(d.label, style: AppTextStyles.bodyLg(
                  Theme.of(context).brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                )),
                onTap: () {
                  Navigator.pop(sheetContext);
                  widget.onDestinationSelected(i);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _topBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = AppStateScope.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(widget.portalLabel, style: AppTextStyles.h1(isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
      actions: [
        ...?widget.actions,
        IconButton(
          tooltip: 'Toggle theme',
          icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          onPressed: app.toggleTheme,
        ),
        const SizedBox(width: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: ProfileAvatar(initials: widget.userInitials, size: 34, showStatusDot: true),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = Responsive.deviceType(context);

    if (deviceType == DeviceType.mobile) {
      final destinations = widget.destinations;
      final showMore = destinations.length > 5;
      final maxTabs = showMore ? 4 : destinations.length;
      final visible = destinations.take(maxTabs).toList();
      final overflow = showMore ? List.generate(destinations.length - maxTabs, (i) => i + maxTabs) : <int>[];

      return Scaffold(
        appBar: _topBar(context),
        body: SafeArea(child: widget.child),
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.currentIndex >= visible.length ? 0 : widget.currentIndex,
          onTap: (i) {
            if (showMore && i == visible.length) {
              _showMoreSheet(context, overflow);
            } else {
              widget.onDestinationSelected(i);
            }
          },
          items: [
            for (final d in visible) BottomNavigationBarItem(icon: Icon(d.icon), activeIcon: Icon(d.selectedIcon), label: d.label),
            if (showMore) const BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
          ],
        ),
      );
    }

    final isDesktop = deviceType == DeviceType.desktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _topBar(context),
      body: Row(
        children: [
          NavigationRail(
            extended: isDesktop && _sidebarExpanded,
            minExtendedWidth: 220,
            backgroundColor: isDark ? AppColors.cardDark : AppColors.card,
            selectedIndex: widget.currentIndex,
            onDestinationSelected: widget.onDestinationSelected,
            leading: isDesktop
                ? Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: IconButton(
                      tooltip: _sidebarExpanded ? 'Collapse sidebar' : 'Expand sidebar',
                      icon: Icon(_sidebarExpanded ? Icons.menu_open_rounded : Icons.menu_rounded),
                      onPressed: () => setState(() => _sidebarExpanded = !_sidebarExpanded),
                    ),
                  )
                : null,
            destinations: [
              for (final d in widget.destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          VerticalDivider(width: 1, color: isDark ? AppColors.borderDark : AppColors.border),
          Expanded(
            child: Container(
              color: isDark ? AppColors.backgroundDark : AppColors.background,
              child: widget.child,
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
