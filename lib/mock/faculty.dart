import 'dart:math';
import '../models/faculty.dart';
import 'department_seeds.dart';

const List<String> _facultyFirstNames = [
  'Emily', 'Raghav', 'Priya', 'Thomas', 'Naomi', 'Marcus', 'Sofia', 'Daniel',
  'Isabelle', 'Kevin', 'Hannah', 'Adrian', 'Grace', 'Leo', 'Amara', 'Robert',
  'Victoria', 'Samuel', 'Nathan', 'Clara', 'Oliver', 'Diana', 'Felix', 'Maya',
  'Benjamin', 'Charlotte', 'Henry', 'Sophie', 'Gabriel', 'Lucia',
];

const List<String> _facultyLastNames = [
  'Carter', 'Iyer', 'Menon', 'Reyes', 'Clarke', 'Webb', 'Alvarez', 'Osei',
  'Laurent', 'Zhao', 'Fischer', 'Kowalski', 'Whitfield', 'Fontaine', 'Nwosu', 'Hale',
  'Simmons', 'Okafor', 'Bennett', 'Moreau', 'Bishop', 'Hartley', 'Grant', 'Ellison',
];

const List<String> _designations = [
  'Assistant Professor', 'Associate Professor', 'Professor', 'Senior Lecturer',
];

/// Subject-name pools used only for the "subjects taught" tags on a
/// faculty profile — the canonical 35-subject catalog lives in
/// `mock/subjects.dart`.
const Map<String, List<String>> subjectNamePool = {
  'dept-cse': ['Operating Systems', 'Database Systems', 'Computer Networks', 'Data Structures'],
  'dept-ece': ['Digital Signal Processing', 'VLSI Design', 'Embedded Systems'],
  'dept-mech': ['Thermodynamics', 'Fluid Mechanics', 'Machine Design'],
  'dept-civil': ['Structural Analysis', 'Geotechnical Engineering', 'Surveying'],
  'dept-eee': ['Power Systems', 'Control Systems', 'Electrical Machines'],
  'dept-it': ['Web Technologies', 'Cloud Computing', 'Cybersecurity'],
  'dept-biotech': ['Genetics', 'Molecular Biology', 'Bioprocess Engineering'],
  'dept-mgmt': ['Marketing Management', 'Financial Accounting', 'Organizational Behavior'],
  'dept-math': ['Linear Algebra', 'Calculus III', 'Probability & Statistics'],
  'dept-des': ['Design Thinking', 'Visual Communication'],
  'dept-pharm': ['Pharmacology', 'Pharmaceutical Chemistry'],
  'dept-law': ['Constitutional Law', 'Contract Law'],
};

/// Exactly 45 faculty, spread across the 12 departments.
const int totalMockFaculty = 45;

List<Faculty> _generateFaculty() {
  final random = Random(7);
  final faculty = <Faculty>[];
  int counter = 1;

  final base = totalMockFaculty ~/ departmentSeeds.length; // 3 each
  final remainder = totalMockFaculty % departmentSeeds.length; // 9 depts get one extra

  for (int d = 0; d < departmentSeeds.length; d++) {
    final dept = departmentSeeds[d];
    final countForDept = base + (d < remainder ? 1 : 0);
    final subjects = subjectNamePool[dept.id] ?? const ['General Studies'];
    for (int i = 0; i < countForDept; i++) {
      final first = _facultyFirstNames[random.nextInt(_facultyFirstNames.length)];
      final last = _facultyLastNames[random.nextInt(_facultyLastNames.length)];
      final name = 'Dr. $first $last';
      final experience = 2 + random.nextInt(22);
      final assignedSubjects = (List<String>.from(subjects)..shuffle(random)).take(2).toList();

      faculty.add(Faculty(
        id: 'fac-${dept.code.toLowerCase()}-$counter',
        name: name,
        employeeId: 'FAC${counter.toString().padLeft(3, '0')}',
        department: dept.name,
        departmentId: dept.id,
        designation: _designations[random.nextInt(_designations.length)],
        experienceYears: experience,
        subjects: assignedSubjects,
        email: '${first.toLowerCase()}.${last.toLowerCase()}@attence.edu',
        phone: '+1 555 ${200 + random.nextInt(700)} ${1000 + random.nextInt(9000)}',
      ));
      counter++;
    }
  }
  return faculty;
}

/// The full faculty dataset — exactly 45 records.
final List<Faculty> mockFaculty = _generateFaculty();

/// Featured faculty member from the spec's "Mock Data Example".
final Faculty featuredFaculty = Faculty(
  id: 'fac-featured-emily',
  name: 'Dr. Emily Carter',
  employeeId: 'FAC018',
  department: 'Computer Science',
  departmentId: 'dept-cse',
  designation: 'Associate Professor',
  experienceYears: 12,
  subjects: const ['Operating Systems', 'Computer Networks'],
  email: 'emily.carter@attence.edu',
  phone: '+1 555 118 4021',
);

/// The signed-in demo faculty member used across the Faculty portal.
final Faculty currentFaculty = featuredFaculty;

List<Faculty> facultyByDepartment(String departmentId) =>
    mockFaculty.where((f) => f.departmentId == departmentId).toList();

Faculty? facultyById(String id) {
  try {
    return mockFaculty.firstWhere((f) => f.id == id);
  } catch (_) {
    return null;
  }
}
