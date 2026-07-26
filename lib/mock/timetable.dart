import 'dart:math';
import '../models/timetable_entry.dart';
import 'department_seeds.dart';
import 'faculty.dart';
import 'rooms.dart';
import 'subjects.dart';

const List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

const List<Map<String, String>> _cseYear3Slots = [
  {'start': '09:00', 'end': '09:50', 'subject': 'Operating Systems', 'code': 'CSE300'},
  {'start': '10:00', 'end': '10:50', 'subject': 'Database Systems', 'code': 'CSE301'},
  {'start': '11:10', 'end': '12:00', 'subject': 'Computer Networks', 'code': 'CSE302'},
  {'start': '12:00', 'end': '12:50', 'subject': 'Data Structures', 'code': 'CSE303'},
  {'start': '14:00', 'end': '14:50', 'subject': 'Machine Learning', 'code': 'CSE304'},
  {'start': '15:00', 'end': '15:50', 'subject': 'Algorithms', 'code': 'CSE305'},
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
        room: roomFor(id),
        departmentId: 'dept-cse',
        year: 'III',
      ));
      id++;
    }
  }
  return entries;
}

final List<TimetableEntry> cseYear3Timetable = _buildCseYear3Timetable();

/// A broader generated timetable across all departments/years, built from
/// the real 35-subject catalog and 45-faculty roster (not invented
/// placeholder names), so the Admin "Timetable" screen has real filtering
/// options that agree with the rest of the data.
List<TimetableEntry> _buildAllTimetables() {
  final random = Random(11);
  final entries = <TimetableEntry>[...cseYear3Timetable];
  final years = ['I', 'II', 'III', 'IV'];

  for (final dept in departmentSeeds) {
    if (dept.id == 'dept-cse') continue;
    final deptSubjects = subjectsByDepartment(dept.id);
    final deptFaculty = facultyByDepartment(dept.id);
    if (deptSubjects.isEmpty || deptFaculty.isEmpty) continue;

    for (final year in years) {
      final slotsForYear = 3 + random.nextInt(3);
      int id = 1;
      for (final day in weekDays.take(5)) {
        for (int i = 0; i < slotsForYear; i++) {
          final hour = 9 + i;
          final subject = deptSubjects[i % deptSubjects.length];
          final faculty = deptFaculty[i % deptFaculty.length];
          entries.add(TimetableEntry(
            id: 'tt-${dept.id}-$year-$day-$id',
            day: day,
            startTime: '${hour.toString().padLeft(2, '0')}:00',
            endTime: '${hour.toString().padLeft(2, '0')}:50',
            subject: subject.name,
            subjectCode: subject.code,
            facultyName: faculty.name,
            room: roomFor(random.nextInt(mockRooms.length)),
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
