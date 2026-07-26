import '../core/constants.dart';

class AttendanceRecord {
  final String id;
  final String studentId;
  final String studentName;
  final String rollNumber;
  final String subject;
  final DateTime date;
  final AttendanceStatus status;

  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.rollNumber,
    required this.subject,
    required this.date,
    required this.status,
  });
}

class AttendanceTrendPoint {
  final String label;
  final double percent;

  const AttendanceTrendPoint(this.label, this.percent);
}

class DepartmentAttendance {
  final String department;
  final double percent;

  const DepartmentAttendance(this.department, this.percent);
}

/// A single dated class occurrence where attendance was taken — distinct
/// from [AttendanceRecord], which is one student's mark within a session.
class AttendanceSession {
  final String id;
  final String subject;
  final String subjectCode;
  final String facultyName;
  final String room;
  final String departmentId;
  final DateTime date;
  final int presentCount;
  final int absentCount;

  const AttendanceSession({
    required this.id,
    required this.subject,
    required this.subjectCode,
    required this.facultyName,
    required this.room,
    required this.departmentId,
    required this.date,
    required this.presentCount,
    required this.absentCount,
  });

  int get totalCount => presentCount + absentCount;
  double get attendancePercent => totalCount == 0 ? 0 : (presentCount / totalCount) * 100;
}
