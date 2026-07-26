class TimetableEntry {
  final String id;
  final String day; // Monday..Saturday
  final String startTime;
  final String endTime;
  final String subject;
  final String subjectCode;
  final String facultyName;
  final String room;
  final String departmentId;
  final String year;
  final bool isCurrent;

  const TimetableEntry({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.subjectCode,
    required this.facultyName,
    required this.room,
    required this.departmentId,
    required this.year,
    this.isCurrent = false,
  });
}
