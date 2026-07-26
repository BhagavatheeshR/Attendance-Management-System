import 'dart:math';
import '../models/faculty.dart';
import 'departments.dart';

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

const Map<String, List<String>> _subjectPool = {
  'dept-cse': ['Operating Systems', 'Database Systems', 'Computer Networks', 'Data Structures', 'Algorithms', 'Machine Learning'],
  'dept-ece': ['Digital Signal Processing', 'VLSI Design', 'Embedded Systems', 'Communication Theory'],
  'dept-mech': ['Thermodynamics', 'Fluid Mechanics', 'Machine Design', 'Manufacturing Processes'],
  'dept-civil': ['Structural Analysis', 'Geotechnical Engineering', 'Surveying', 'Construction Management'],
  'dept-eee': ['Power Systems', 'Control Systems', 'Electrical Machines'],
  'dept-it': ['Web Technologies', 'Cloud Computing', 'Cybersecurity', 'Software Engineering'],
  'dept-biotech': ['Genetics', 'Molecular Biology', 'Bioprocess Engineering'],
  'dept-chem': ['Chemical Reaction Engineering', 'Process Control', 'Mass Transfer'],
  'dept-arch': ['Architectural Design', 'Urban Planning', 'Building Technology'],
  'dept-mgmt': ['Marketing Management', 'Financial Accounting', 'Organizational Behavior'],
  'dept-math': ['Linear Algebra', 'Calculus III', 'Probability & Statistics'],
  'dept-phys': ['Quantum Mechanics', 'Electromagnetism', 'Thermal Physics'],
  'dept-eng': ['Technical Communication', 'World Literature'],
  'dept-des': ['Design Thinking', 'Visual Communication'],
  'dept-pharm': ['Pharmacology', 'Pharmaceutical Chemistry'],
  'dept-agri': ['Soil Science', 'Crop Physiology'],
  'dept-law': ['Constitutional Law', 'Contract Law'],
  'dept-med': ['Human Anatomy', 'Clinical Nutrition'],
};

List<Faculty> _generateFaculty() {
  final random = Random(7);
  final faculty = <Faculty>[];
  int counter = 1;

  for (final dept in mockDepartments) {
    final countForDept = 3 + random.nextInt(3); // 3-5 shown per dept
    final subjects = _subjectPool[dept.id] ?? const ['General Studies'];
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
