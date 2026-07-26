import 'constants.dart';

/// Which build this binary is: chosen by which `main` entry point was used
/// to launch the app (see `lib/admin_main.dart` and
/// `lib/staff_student_main.dart`), not by runtime platform detection. This
/// is what lets you ship two separate binaries — an Admin web console and
/// a Faculty/Student mobile app — from the same codebase.
enum AppFlavor {
  /// Administrator console — built via `lib/admin_main.dart`, normally
  /// deployed to web.
  admin,

  /// Faculty + Student experience — built via
  /// `lib/staff_student_main.dart`, normally shipped as the mobile app.
  staffStudent,
}

extension AppFlavorX on AppFlavor {
  /// Roles selectable at login for this flavor.
  List<UserRole> get availableRoles {
    switch (this) {
      case AppFlavor.admin:
        return const [UserRole.admin];
      case AppFlavor.staffStudent:
        return const [UserRole.faculty, UserRole.student];
    }
  }

  String get label {
    switch (this) {
      case AppFlavor.admin:
        return 'Admin console';
      case AppFlavor.staffStudent:
        return 'Faculty & Student app';
    }
  }
}
