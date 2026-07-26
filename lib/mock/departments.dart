import '../models/department.dart';
import 'department_seeds.dart';
import 'faculty.dart';
import 'students.dart';
import 'subjects.dart';

/// Builds the final department directory with counts computed directly
/// from the generated student/faculty/subject datasets, so the numbers
/// shown here always agree with what the list/detail screens actually
/// display — no hand-typed totals that can drift out of sync.
List<Department> _buildDepartments() {
  return departmentSeeds.map((seed) {
    final deptStudents = studentsByDepartment(seed.id);
    final deptFaculty = facultyByDepartment(seed.id);
    final deptSubjects = subjectsByDepartment(seed.id);
    final avgAttendance = deptStudents.isEmpty
        ? 0.0
        : deptStudents.map((s) => s.attendancePercent).reduce((a, b) => a + b) / deptStudents.length;

    return Department(
      id: seed.id,
      name: seed.name,
      code: seed.code,
      headOfDepartment: seed.headOfDepartment,
      studentCount: deptStudents.length,
      facultyCount: deptFaculty.length,
      subjectCount: deptSubjects.length,
      averageAttendance: double.parse(avgAttendance.toStringAsFixed(1)),
    );
  }).toList();
}

/// The full department directory — exactly 12 records, with
/// student/faculty/subject counts computed from the real generated data.
final List<Department> mockDepartments = _buildDepartments();

Department departmentById(String id) =>
    mockDepartments.firstWhere((d) => d.id == id, orElse: () => mockDepartments.first);
