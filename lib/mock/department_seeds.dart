/// Minimal department seed data — no dependencies, no derived counts.
/// [mock/departments.dart] combines this with the generated students,
/// faculty, and subjects to build the final [Department] objects with
/// accurate (not guessed) counts. Exactly 12 departments per spec.
class DepartmentSeed {
  final String id;
  final String name;
  final String code;
  final String headOfDepartment;

  const DepartmentSeed({
    required this.id,
    required this.name,
    required this.code,
    required this.headOfDepartment,
  });
}

const List<DepartmentSeed> departmentSeeds = [
  DepartmentSeed(id: 'dept-cse', name: 'Computer Science', code: 'CSE', headOfDepartment: 'Dr. Emily Carter'),
  DepartmentSeed(id: 'dept-ece', name: 'Electronics & Communication', code: 'ECE', headOfDepartment: 'Dr. Raghav Iyer'),
  DepartmentSeed(id: 'dept-mech', name: 'Mechanical Engineering', code: 'MECH', headOfDepartment: 'Dr. Priya Menon'),
  DepartmentSeed(id: 'dept-civil', name: 'Civil Engineering', code: 'CIVIL', headOfDepartment: 'Dr. Thomas Reyes'),
  DepartmentSeed(id: 'dept-eee', name: 'Electrical Engineering', code: 'EEE', headOfDepartment: 'Dr. Naomi Clarke'),
  DepartmentSeed(id: 'dept-it', name: 'Information Technology', code: 'IT', headOfDepartment: 'Dr. Marcus Webb'),
  DepartmentSeed(id: 'dept-biotech', name: 'Biotechnology', code: 'BT', headOfDepartment: 'Dr. Sofia Alvarez'),
  DepartmentSeed(id: 'dept-mgmt', name: 'Business Management', code: 'MBA', headOfDepartment: 'Dr. Kevin Zhao'),
  DepartmentSeed(id: 'dept-math', name: 'Mathematics', code: 'MATH', headOfDepartment: 'Dr. Hannah Fischer'),
  DepartmentSeed(id: 'dept-des', name: 'Design', code: 'DES', headOfDepartment: 'Dr. Leo Fontaine'),
  DepartmentSeed(id: 'dept-pharm', name: 'Pharmacy', code: 'PHARM', headOfDepartment: 'Dr. Amara Nwosu'),
  DepartmentSeed(id: 'dept-law', name: 'Law', code: 'LAW', headOfDepartment: 'Dr. Victoria Simmons'),
];

DepartmentSeed departmentSeedById(String id) =>
    departmentSeeds.firstWhere((d) => d.id == id, orElse: () => departmentSeeds.first);
