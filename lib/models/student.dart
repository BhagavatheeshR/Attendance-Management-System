class Student {
  final String id;
  final String name;
  final String rollNumber;
  final String department;
  final String departmentId;
  final String year;
  final double attendancePercent;
  final String email;
  final String phone;
  final String? avatarSeed;
  final String status; // Active, Inactive, On Leave

  const Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.departmentId,
    required this.year,
    required this.attendancePercent,
    required this.email,
    required this.phone,
    this.avatarSeed,
    this.status = 'Active',
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}
