import 'dart:math';
import '../core/constants.dart';
import '../models/attendance_record.dart';
import '../models/student.dart';
import 'departments.dart';
import 'faculty.dart';
import 'rooms.dart';
import 'students.dart';
import 'subjects.dart';

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

/// Exactly 320 dated class sessions, spread across the 35-subject catalog
/// — matches the spec's "320 Attendance Sessions" and backs the Recent
/// Sessions lists, the attendance calendar/heat map, and reports.
const int totalMockSessions = 320;

List<AttendanceSession> _buildSessions() {
  final random = Random(29);
  final sessions = <AttendanceSession>[];
  final now = DateTime.now();
  int counter = 1;

  final base = totalMockSessions ~/ mockSubjects.length;
  final remainder = totalMockSessions % mockSubjects.length;

  for (int s = 0; s < mockSubjects.length; s++) {
    final subject = mockSubjects[s];
    final sessionsForSubject = base + (s < remainder ? 1 : 0);
    final faculty = facultyById(subject.facultyId);
    final classSize = 18 + random.nextInt(43); // 18-60 students in the class

    for (int i = 0; i < sessionsForSubject; i++) {
      final date = now.subtract(Duration(days: random.nextInt(90)));
      final present = (classSize * (0.82 + random.nextDouble() * 0.16)).round().clamp(0, classSize);
      sessions.add(AttendanceSession(
        id: 'session-${subject.code.toLowerCase()}-$counter',
        subject: subject.name,
        subjectCode: subject.code,
        facultyName: faculty?.name ?? 'Staff',
        room: roomFor(counter),
        departmentId: subject.departmentId,
        date: date,
        presentCount: present,
        absentCount: classSize - present,
      ));
      counter++;
    }
  }
  sessions.sort((a, b) => b.date.compareTo(a.date));
  return sessions;
}

/// The full session log — exactly 320 records.
final List<AttendanceSession> mockAttendanceSessions = _buildSessions();

/// Exactly 10,000 individual attendance marks: 40 per student across all
/// 250 students, matching the spec's "10,000 Attendance Records". This is
/// the bulk dataset behind the Enterprise DataTable / calendar / heat map
/// — separate from [currentStudentAttendanceHistory], which is a
/// hand-curated slice for the single demo student's own history screen.
const int recordsPerStudent = 40;

List<AttendanceRecord> _buildBulkRecords() {
  final random = Random(37);
  final records = <AttendanceRecord>[];
  final now = DateTime.now();

  for (final student in mockStudents) {
    final deptSubjects = subjectsByDepartment(student.departmentId);
    for (int i = 0; i < recordsPerStudent; i++) {
      final subject = deptSubjects.isEmpty ? null : deptSubjects[random.nextInt(deptSubjects.length)];
      final date = now.subtract(Duration(days: random.nextInt(84)));
      final roll = random.nextInt(100);
      final status = roll < 87
          ? AttendanceStatus.present
          : roll < 94
              ? AttendanceStatus.late
              : roll < 97
                  ? AttendanceStatus.excused
                  : AttendanceStatus.absent;
      records.add(AttendanceRecord(
        id: 'bulk-${student.id}-$i',
        studentId: student.id,
        studentName: student.name,
        rollNumber: student.rollNumber,
        subject: subject?.name ?? 'General Studies',
        date: date,
        status: status,
      ));
    }
  }
  return records;
}

/// The full attendance ledger — exactly 10,000 records (250 students x 40).
final List<AttendanceRecord> mockAttendanceRecords = _buildBulkRecords();

/// Status breakdown across the full 10,000-record ledger — backs the
/// "Attendance Composition" donut chart on Reports.
Map<AttendanceStatus, int> get attendanceStatusBreakdown {
  final counts = {for (final s in AttendanceStatus.values) s: 0};
  for (final r in mockAttendanceRecords) {
    counts[r.status] = (counts[r.status] ?? 0) + 1;
  }
  return counts;
}

/// Department (rows) x weekday (columns) average attendance %, computed
/// live from the full attendance ledger — backs the "Attendance Heat Map"
/// on Reports so it never disagrees with the raw records.
const List<String> heatmapWeekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

List<List<double>> get departmentWeekdayHeatmap {
  final present = {for (final d in mockDepartments) d.code: List.filled(7, 0)};
  final total = {for (final d in mockDepartments) d.code: List.filled(7, 0)};

  for (final r in mockAttendanceRecords) {
    final student = studentById(r.studentId);
    if (student == null) continue;
    final dept = departmentById(student.departmentId);
    final wd = r.date.weekday - 1; // 0 = Mon
    total[dept.code]![wd]++;
    if (r.status == AttendanceStatus.present || r.status == AttendanceStatus.late) {
      present[dept.code]![wd]++;
    }
  }

  return [
    for (final dept in mockDepartments)
      [
        for (int wd = 0; wd < 7; wd++)
          total[dept.code]![wd] == 0 ? 0.0 : (present[dept.code]![wd]! / total[dept.code]![wd]!) * 100,
      ],
  ];
}
