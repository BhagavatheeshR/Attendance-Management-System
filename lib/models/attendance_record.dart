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
