class Faculty {
  final String id;
  final String name;
  final String employeeId;
  final String department;
  final String departmentId;
  final String designation;
  final int experienceYears;
  final List<String> subjects;
  final String email;
  final String phone;
  final String status;

  const Faculty({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.department,
    required this.departmentId,
    required this.designation,
    required this.experienceYears,
    required this.subjects,
    required this.email,
    required this.phone,
    this.status = 'Active',
  });

  String get initials {
    final parts = name.replaceFirst('Dr. ', '').replaceFirst('Prof. ', '').trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}
