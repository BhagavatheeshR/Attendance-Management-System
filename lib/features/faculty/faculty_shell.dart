import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_shell.dart';
import '../../mock/faculty.dart';

const List<AppNavDestination> facultyDestinations = [
  AppNavDestination(icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded, label: 'Dashboard'),
  AppNavDestination(icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check_rounded, label: 'Attendance'),
  AppNavDestination(icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month_rounded, label: 'Schedule'),
  AppNavDestination(icon: Icons.bar_chart_outlined, selectedIcon: Icons.bar_chart_rounded, label: 'Reports'),
  AppNavDestination(icon: Icons.notifications_outlined, selectedIcon: Icons.notifications_rounded, label: 'Notifications'),
  AppNavDestination(icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: 'Profile'),
];

/// Scaffold used by every Faculty tab route.
class FacultyShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const FacultyShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      portalLabel: 'Faculty Portal',
      userInitials: currentFaculty.initials,
      destinations: facultyDestinations,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: (i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex),
      child: navigationShell,
    );
  }
}
