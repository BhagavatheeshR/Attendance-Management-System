/// Fixed set of 18 rooms shared across the timetable, matching the spec's
/// "18 Rooms" exactly — every class is held in one of these, never a
/// randomly invented room number.
const List<String> mockRooms = [
  'Room 101', 'Room 102', 'Room 103', 'Room 104',
  'Room 201', 'Room 202', 'Room 203', 'Room 204',
  'Lab 301', 'Lab 302', 'Lab 303',
  'Seminar Hall A', 'Seminar Hall B',
  'Auditorium',
  'Design Studio', 'Moot Court',
  'Conference Room 1', 'Conference Room 2',
];

String roomFor(int index) => mockRooms[index % mockRooms.length];
