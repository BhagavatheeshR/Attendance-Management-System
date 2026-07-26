import 'dart:math';
import '../models/timetable_entry.dart';
import 'departments.dart';

const List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

const List<Map<String, String>> _cseYear3Slots = [
  {'start': '09:00', 'end': '09:50', 'subject': 'Operating Systems', 'code': 'CS301'},
  {'start': '10:00', 'end': '10:50', 'subject': 'Database Systems', 'code': 'CS302'},
  {'start': '11:10', 'end': '12:00', 'subject': 'Computer Networks', 'code': 'CS303'},
  {'start': '12:00', 'end': '12:50', 'subject': 'Data Structures', 'code': 'CS304'},
  {'start': '14:00', 'end': '14:50', 'subject': 'Machine Learning', 'code': 'CS305'},
  {'start': '15:00', 'end': '15:50', 'subject': 'Algorithms', 'code': 'CS306'},
];

/// The fixed weekly timetable for CSE - Year III, shared by the demo
/// student (Sarathy) and demo faculty (Dr. Emily Carter) so both portals
/// tell a consistent story.
List<TimetableEntry> _buildCseYear3Timetable() {
  final entries = <TimetableEntry>[];
  int id = 1;
  for (final day in weekDays.take(5)) {
    for (final slot in _cseYear3Slots) {
      entries.add(TimetableEntry(
        id: 'tt-cse3-$id',
        day: day,
        startTime: slot['start']!,
        endTime: slot['end']!,
        subject: slot['subject']!,
        subjectCode: slot['code']!,
        facultyName: 'Dr. Emily Carter',
        room: 'Room ${201 + (id % 6)}',
        departmentId: 'dept-cse',
        year: 'III',
      ));
      id++;
    }
  }
  return entries;
}

final List<TimetableEntry> cseYear3Timetable = _buildCseYear3Timetable();

/// A broader (lighter) generated timetable across all departments/years so
/// the Admin "Create/View Timetable" screen has real filtering options.
List<TimetableEntry> _buildAllTimetables() {
  final random = Random(11);
  final entries = <TimetableEntry>[...cseYear3Timetable];
  final genericSubjects = [
    'Core Theory', 'Applied Lab', 'Seminar', 'Workshop', 'Studio Session', 'Tutorial',
  ];
  final years = ['I', 'II', 'III', 'IV'];

  for (final dept in mockDepartments) {
    if (dept.id == 'dept-cse') continue;
    for (final year in years) {
      final slotsForYear = 3 + random.nextInt(3);
      int id = 1;
      for (final day in weekDays.take(5)) {
        for (int i = 0; i < slotsForYear; i++) {
          final hour = 9 + i * 1;
          entries.add(TimetableEntry(
            id: 'tt-${dept.id}-$year-$day-$id',
            day: day,
            startTime: '${hour.toString().padLeft(2, '0')}:00',
            endTime: '${hour.toString().padLeft(2, '0')}:50',
            subject: '${genericSubjects[random.nextInt(genericSubjects.length)]} ${i + 1}',
            subjectCode: '${dept.code}${100 + i}',
            facultyName: 'Dept. Faculty',
            room: 'Room ${300 + random.nextInt(60)}',
            departmentId: dept.id,
            year: year,
          ));
          id++;
        }
      }
    }
  }
  return entries;
}

final List<TimetableEntry> mockTimetable = _buildAllTimetables();

List<TimetableEntry> timetableFor({required String departmentId, required String year}) =>
    mockTimetable.where((t) => t.departmentId == departmentId && t.year == year).toList();

List<TimetableEntry> timetableForDay({
  required String departmentId,
  required String year,
  required String day,
}) =>
    timetableFor(departmentId: departmentId, year: year).where((t) => t.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

const List<String> _liveOrder = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

String todayName() => _liveOrder[DateTime.now().weekday - 1];
