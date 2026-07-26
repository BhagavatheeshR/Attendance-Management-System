import 'dart:math';
import '../models/subject.dart';
import 'department_seeds.dart';
import 'faculty.dart';

/// Exactly 35 subjects, spread across the 12 departments and assigned to
/// real faculty members from the same department.
const int totalMockSubjects = 35;

List<Subject> _generateSubjects() {
  final random = Random(13);
  final subjects = <Subject>[];
  int counter = 1;

  final base = totalMockSubjects ~/ departmentSeeds.length; // 2 each
  final remainder = totalMockSubjects % departmentSeeds.length; // 11 depts get one extra

  for (int d = 0; d < departmentSeeds.length; d++) {
    final dept = departmentSeeds[d];
    final countForDept = base + (d < remainder ? 1 : 0);
    final names = subjectNamePool[dept.id] ?? const ['General Studies'];
    final deptFaculty = facultyByDepartment(dept.id);

    for (int i = 0; i < countForDept; i++) {
      final name = names[i % names.length];
      final assignedFaculty = deptFaculty.isEmpty ? null : deptFaculty[i % deptFaculty.length];
      subjects.add(Subject(
        id: 'sub-${dept.code.toLowerCase()}-$counter',
        name: countForDept > names.length && i >= names.length ? '$name ${(i ~/ names.length) + 1}' : name,
        code: '${dept.code}${300 + i}',
        departmentId: dept.id,
        facultyId: assignedFaculty?.id ?? 'fac-unassigned',
        credits: 2 + random.nextInt(3),
      ));
      counter++;
    }
  }
  return subjects;
}

/// The full subject catalog — exactly 35 records.
final List<Subject> mockSubjects = _generateSubjects();

List<Subject> subjectsByDepartment(String departmentId) =>
    mockSubjects.where((s) => s.departmentId == departmentId).toList();
