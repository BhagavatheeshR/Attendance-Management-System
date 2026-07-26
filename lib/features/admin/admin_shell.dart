import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_shell.dart';

const List<AppNavDestination> adminDestinations = [
  AppNavDestination(icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded, label: 'Dashboard'),
  AppNavDestination(icon: Icons.school_outlined, selectedIcon: Icons.school_rounded, label: 'Students'),
  AppNavDestination(icon: Icons.badge_outlined, selectedIcon: Icons.badge_rounded, label: 'Faculty'),
  AppNavDestination(icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month_rounded, label: 'Timetable'),
  AppNavDestination(icon: Icons.account_balance_outlined, selectedIcon: Icons.account_balance_rounded, label: 'Departments'),
  AppNavDestination(icon: Icons.bar_chart_outlined, selectedIcon: Icons.bar_chart_rounded, label: 'Reports'),
  AppNavDestination(icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: 'Profile'),
];

/// Scaffold used by every Admin tab route (dashboard, students, faculty…).
class AdminShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AdminShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      portalLabel: 'Admin Portal',
      userInitials: 'AD',
      destinations: adminDestinations,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: (i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex),
      child: navigationShell,
    );
  }
}
