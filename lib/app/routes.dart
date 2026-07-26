import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_flavor.dart';
import '../core/page_transitions.dart';
import '../features/auth/login_screen.dart';

import '../features/admin/admin_shell.dart';
import '../features/admin/dashboard/admin_dashboard_screen.dart';
import '../features/admin/students/student_list_screen.dart';
import '../features/admin/students/student_detail_screen.dart';
import '../features/admin/faculty/faculty_list_screen.dart';
import '../features/admin/faculty/faculty_detail_screen.dart';
import '../features/admin/timetable/admin_timetable_screen.dart';
import '../features/admin/departments/department_list_screen.dart';
import '../features/admin/departments/department_detail_screen.dart';
import '../features/admin/reports/admin_reports_screen.dart';
import '../features/admin/profile/admin_profile_screen.dart';

import '../features/faculty/faculty_shell.dart';
import '../features/faculty/dashboard/faculty_dashboard_screen.dart';
import '../features/faculty/attendance/take_attendance_screen.dart';
import '../features/faculty/attendance/mark_attendance_screen.dart';
import '../features/faculty/schedule/faculty_schedule_screen.dart';
import '../features/faculty/reports/faculty_reports_screen.dart';
import '../features/faculty/notifications/faculty_notifications_screen.dart';
import '../features/faculty/profile/faculty_profile_screen.dart';

import '../features/student/student_shell.dart';
import '../features/student/dashboard/student_dashboard_screen.dart';
import '../features/student/attendance/student_attendance_screen.dart';
import '../features/student/timetable/student_timetable_screen.dart';
import '../features/student/announcements/student_announcements_screen.dart';
import '../features/student/profile/student_profile_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Builds the router for a given [flavor]. Each entry point
/// (`admin_main.dart`, `staff_student_main.dart`, and the convenience
/// default `main.dart`) calls this with its own fixed flavor, so which
/// portals exist in the binary is decided at launch — not guessed from the
/// runtime platform.
GoRouter buildRouter(AppFlavor flavor) => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  // Belt-and-suspenders: also block direct/deep links that try to cross
  // the Admin vs Faculty/Student boundary, in addition to the login
  // screen's role picker already only offering roles for this flavor.
  redirect: (context, state) {
    final path = state.matchedLocation;
    if (flavor == AppFlavor.admin && (path.startsWith('/faculty') || path.startsWith('/student'))) {
      return '/login';
    }
    if (flavor == AppFlavor.staffStudent && path.startsWith('/admin')) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/login', pageBuilder: (context, state) => fadePage(child: LoginScreen(flavor: flavor), state: state)),

    // ---------------- Admin ----------------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AdminShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/admin/dashboard', builder: (context, state) => const AdminDashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/admin/students',
            builder: (context, state) => const StudentListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) => slidePage(
                  child: StudentDetailScreen(studentId: state.pathParameters['id']!),
                  state: state,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/admin/faculty',
            builder: (context, state) => const FacultyListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) => slidePage(
                  child: FacultyDetailScreen(facultyId: state.pathParameters['id']!),
                  state: state,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/admin/timetable', builder: (context, state) => const AdminTimetableScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/admin/departments',
            builder: (context, state) => const DepartmentListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) => slidePage(
                  child: DepartmentDetailScreen(departmentId: state.pathParameters['id']!),
                  state: state,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/admin/reports', builder: (context, state) => const AdminReportsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/admin/profile', builder: (context, state) => const AdminProfileScreen()),
        ]),
      ],
    ),

    // ---------------- Faculty ----------------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => FacultyShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/faculty/dashboard', builder: (context, state) => const FacultyDashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/faculty/attendance',
            builder: (context, state) => const TakeAttendanceScreen(),
            routes: [
              GoRoute(
                path: 'session/:classId',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) => slidePage(
                  child: MarkAttendanceScreen(classId: state.pathParameters['classId']!),
                  state: state,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/faculty/schedule', builder: (context, state) => const FacultyScheduleScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/faculty/reports', builder: (context, state) => const FacultyReportsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/faculty/notifications', builder: (context, state) => const FacultyNotificationsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/faculty/profile', builder: (context, state) => const FacultyProfileScreen()),
        ]),
      ],
    ),

    // ---------------- Student ----------------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => StudentShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/student/dashboard', builder: (context, state) => const StudentDashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/student/attendance', builder: (context, state) => const StudentAttendanceScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/student/timetable', builder: (context, state) => const StudentTimetableScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/student/announcements', builder: (context, state) => const StudentAnnouncementsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/student/profile', builder: (context, state) => const StudentProfileScreen()),
        ]),
      ],
    ),
  ],
);
