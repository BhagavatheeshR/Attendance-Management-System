import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_shell.dart';
import '../../mock/students.dart';

const List<AppNavDestination> studentDestinations = [
  AppNavDestination(icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded, label: 'Dashboard'),
  AppNavDestination(icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check_rounded, label: 'Attendance'),
  AppNavDestination(icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month_rounded, label: 'Timetable'),
  AppNavDestination(icon: Icons.campaign_outlined, selectedIcon: Icons.campaign_rounded, label: 'Announcements'),
  AppNavDestination(icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: 'Profile'),
];

/// Scaffold used by every Student tab route.
class StudentShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const StudentShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      portalLabel: 'Student Portal',
      userInitials: currentStudent.initials,
      destinations: studentDestinations,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: (i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex),
      child: navigationShell,
    );
  }
}
