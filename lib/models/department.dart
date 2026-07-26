class Department {
  final String id;
  final String name;
  final String code;
  final String headOfDepartment;
  final int studentCount;
  final int facultyCount;
  final int subjectCount;
  final double averageAttendance;

  const Department({
    required this.id,
    required this.name,
    required this.code,
    required this.headOfDepartment,
    required this.studentCount,
    required this.facultyCount,
    required this.subjectCount,
    required this.averageAttendance,
  });
}
