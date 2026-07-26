import 'dart:math';
import '../core/constants.dart';
import '../models/attendance_record.dart';
import '../models/student.dart';
import 'departments.dart';
import 'students.dart';

/// Overall attendance shown on the Admin dashboard hero stat.
const double todaysOverallAttendance = 96.4;

/// Weekly attendance trend (Mon-Sat) used by the "Attendance Trend" /
/// "Weekly Attendance" charts on Admin & Faculty dashboards.
const List<AttendanceTrendPoint> weeklyAttendanceTrend = [
  AttendanceTrendPoint('Mon', 95.2),
  AttendanceTrendPoint('Tue', 96.8),
  AttendanceTrendPoint('Wed', 94.1),
  AttendanceTrendPoint('Thu', 97.3),
  AttendanceTrendPoint('Fri', 93.6),
  AttendanceTrendPoint('Sat', 91.4),
];

/// Six-month attendance trend for the longer-range chart on Reports.
const List<AttendanceTrendPoint> monthlyAttendanceTrend = [
  AttendanceTrendPoint('Feb', 91.2),
  AttendanceTrendPoint('Mar', 92.6),
  AttendanceTrendPoint('Apr', 93.8),
  AttendanceTrendPoint('May', 94.5),
  AttendanceTrendPoint('Jun', 95.9),
  AttendanceTrendPoint('Jul', 96.4),
];

/// Department comparison chart data, derived straight from the department
/// directory so numbers never disagree across screens.
List<DepartmentAttendance> get departmentAttendanceComparison => mockDepartments
    .map((d) => DepartmentAttendance(d.code, d.averageAttendance))
    .toList();

/// Subject-wise attendance for "Subject Analytics" chart.
const List<DepartmentAttendance> subjectAttendanceAnalytics = [
  DepartmentAttendance('Operating Systems', 95.4),
  DepartmentAttendance('Database Systems', 93.8),
  DepartmentAttendance('Computer Networks', 91.2),
  DepartmentAttendance('Data Structures', 96.1),
  DepartmentAttendance('Machine Learning', 89.7),
  DepartmentAttendance('Algorithms', 94.3),
];

/// Student growth over the last six academic years, for "Student Growth" chart.
const List<AttendanceTrendPoint> studentGrowthTrend = [
  AttendanceTrendPoint('2021', 9840),
  AttendanceTrendPoint('2022', 10510),
  AttendanceTrendPoint('2023', 11280),
  AttendanceTrendPoint('2024', 11960),
  AttendanceTrendPoint('2025', 12420),
  AttendanceTrendPoint('2026', 12846),
];

/// Faculty workload (avg teaching hours/week) for "Faculty Workload" chart.
const List<DepartmentAttendance> facultyWorkload = [
  DepartmentAttendance('CSE', 18.5),
  DepartmentAttendance('ECE', 16.2),
  DepartmentAttendance('MECH', 15.8),
  DepartmentAttendance('CIVIL', 14.9),
  DepartmentAttendance('EEE', 16.7),
  DepartmentAttendance('IT', 17.3),
];

/// A 54-student roster for the demo "Database Systems" session taught by
/// Dr. Emily Carter (CSE - Year III), used on the Faculty "Take Attendance"
/// screen. 49 present / 5 absent, matching the dashboard summary.
List<Student> _buildCurrentSessionRoster() {
  final random = Random(21);
  final base = List<Student>.from(studentsByDepartment('dept-cse'));
  final roster = <Student>[];
  for (int i = 0; i < 54; i++) {
    final template = base[i % base.length];
    roster.add(Student(
      id: 'roster-cse3-$i',
      name: i < base.length ? template.name : '${template.name} ${String.fromCharCode(65 + (i % 26))}',
      rollNumber: 'CSE23${(41 + i).toString().padLeft(3, '0')}',
      department: 'Computer Science',
      departmentId: 'dept-cse',
      year: 'III',
      attendancePercent: double.parse((78 + random.nextInt(21) + random.nextDouble()).toStringAsFixed(1)),
      email: 'student$i@attence.edu',
      phone: '+1 555 400 ${1000 + i}',
    ));
  }
  return roster;
}

final List<Student> currentSessionRoster = _buildCurrentSessionRoster();

/// Fixed present/absent split matching the Faculty dashboard spec (49 / 5).
final Set<String> currentSessionAbsentIds =
    currentSessionRoster.take(5).map((s) => s.id).toSet();

bool isMarkedPresent(String studentId) => !currentSessionAbsentIds.contains(studentId);

/// Attendance history for the signed-in demo student (Sarathy), last 20
/// sessions across their timetable subjects.
List<AttendanceRecord> _buildStudentHistory() {
  final random = Random(5);
  final subjects = [
    'Operating Systems',
    'Database Systems',
    'Computer Networks',
    'Data Structures',
    'Machine Learning',
    'Algorithms',
  ];
  final records = <AttendanceRecord>[];
  final now = DateTime.now();
  for (int i = 0; i < 24; i++) {
    final date = now.subtract(Duration(days: i));
    final subject = subjects[i % subjects.length];
    final roll = random.nextInt(100);
    final status = roll < 88
        ? AttendanceStatus.present
        : roll < 95
            ? AttendanceStatus.late
            : roll < 98
                ? AttendanceStatus.excused
                : AttendanceStatus.absent;
    records.add(AttendanceRecord(
      id: 'att-sarathy-$i',
      studentId: currentStudent.id,
      studentName: currentStudent.name,
      rollNumber: currentStudent.rollNumber,
      subject: subject,
      date: date,
      status: status,
    ));
  }
  return records;
}

final List<AttendanceRecord> currentStudentAttendanceHistory = _buildStudentHistory();
