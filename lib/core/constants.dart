/// App-wide constants and enums that aren't tied to a single feature.
class AppConstants {
  AppConstants._();

  static const String appName = 'Attence';
  static const String appTagline = 'Attendance & academics, unified.';
}

enum UserRole { admin, faculty, student }

extension UserRoleX on UserRole {
  String get label {
    switch (this) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.faculty:
        return 'Faculty';
      case UserRole.student:
        return 'Student';
    }
  }

  String get shortLabel {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.faculty:
        return 'Faculty';
      case UserRole.student:
        return 'Student';
    }
  }
}

enum AttendanceStatus { present, absent, late, excused }

extension AttendanceStatusX on AttendanceStatus {
  String get label {
    switch (this) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.excused:
        return 'Excused';
    }
  }
}
