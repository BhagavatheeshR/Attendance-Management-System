import 'dart:math';
import '../models/student.dart';
import 'department_seeds.dart';

const List<String> _firstNames = [
  'Aarav', 'Vivaan', 'Aditya', 'Vihaan', 'Arjun', 'Sai', 'Reyansh', 'Krishna',
  'Ishaan', 'Rohan', 'Kabir', 'Aryan', 'Dhruv', 'Karan', 'Nikhil', 'Yash',
  'Ananya', 'Diya', 'Isha', 'Kavya', 'Meera', 'Nisha', 'Priya', 'Riya',
  'Saanvi', 'Tara', 'Zara', 'Anika', 'Ira', 'Myra', 'Sarathy', 'Aisha',
  'Liam', 'Noah', 'Ethan', 'Mason', 'Lucas', 'Oliver', 'Elijah', 'James',
  'Emma', 'Olivia', 'Ava', 'Sophia', 'Isabella', 'Mia', 'Charlotte', 'Amelia',
  'Daniel', 'Marcus', 'Nathan', 'Samuel', 'Jonas', 'Felix', 'Hugo', 'Leon',
  'Grace', 'Hannah', 'Chloe', 'Zoe', 'Lily', 'Ella', 'Nora', 'Ruby',
  'Wei', 'Jin', 'Haruto', 'Kenji', 'Min-jun', 'Ji-woo', 'Yuki', 'Sora',
  'Fatima', 'Amara', 'Layla', 'Noor', 'Omar', 'Yusuf', 'Zayn', 'Adam',
];

const List<String> _lastNames = [
  'Sharma', 'Verma', 'Gupta', 'Reddy', 'Nair', 'Iyer', 'Menon', 'Rao',
  'Patel', 'Shah', 'Chatterjee', 'Banerjee', 'Kapoor', 'Malhotra', 'Joshi', 'Desai',
  'Carter', 'Walker', 'Bennett', 'Hughes', 'Foster', 'Bryant', 'Reyes', 'Sanders',
  'Fischer', 'Weber', 'Klein', 'Novak', 'Kowalski', 'Muller', 'Andersson', 'Berg',
  'Tanaka', 'Sato', 'Kim', 'Park', 'Chen', 'Wang', 'Zhao', 'Liu',
  'Nwosu', 'Okafor', 'Adeyemi', 'Mensah', 'Osei', 'Diallo', 'Hassan', 'Farouk',
];

const List<String> _years = ['I', 'II', 'III', 'IV'];

/// Exactly 250 students, spread evenly across the 12 departments.
const int totalMockStudents = 250;

List<Student> _generateStudents() {
  final random = Random(42);
  final students = <Student>[];
  int counter = 1;

  final base = totalMockStudents ~/ departmentSeeds.length; // 20 each
  final remainder = totalMockStudents % departmentSeeds.length; // extra 10, one per first 10 depts

  for (int d = 0; d < departmentSeeds.length; d++) {
    final dept = departmentSeeds[d];
    final countForDept = base + (d < remainder ? 1 : 0);
    for (int i = 0; i < countForDept; i++) {
      final first = _firstNames[random.nextInt(_firstNames.length)];
      final last = _lastNames[random.nextInt(_lastNames.length)];
      final name = '$first $last';
      final year = _years[random.nextInt(_years.length)];
      final yearSuffix = (24 - _years.indexOf(year)).toString().padLeft(2, '0');
      final roll = '${dept.code}$yearSuffix${counter.toString().padLeft(3, '0')}';
      final attendance = 72 + random.nextInt(27) + random.nextDouble();
      final status = attendance < 75 ? 'At Risk' : 'Active';

      students.add(Student(
        id: 'stu-${dept.code.toLowerCase()}-$counter',
        name: name,
        rollNumber: roll,
        department: dept.name,
        departmentId: dept.id,
        year: year,
        attendancePercent: double.parse(attendance.clamp(0, 100).toStringAsFixed(1)),
        email: '${first.toLowerCase()}.${last.toLowerCase()}$counter@attence.edu',
        phone: '+1 555 ${100 + random.nextInt(800)} ${1000 + random.nextInt(9000)}',
        status: status,
      ));
      counter++;
    }
  }
  return students;
}

/// The full student dataset — exactly 250 records.
final List<Student> mockStudents = _generateStudents();

/// The signed-in demo student used across the Student portal ("Hello Sarathy").
final Student currentStudent = Student(
  id: 'stu-current-sarathy',
  name: 'Sarathy Bhagavatheesh',
  rollNumber: 'CSE23041',
  department: 'Computer Science',
  departmentId: 'dept-cse',
  year: 'III',
  attendancePercent: 92.0,
  email: 'sarathy.b@attence.edu',
  phone: '+1 555 123 4567',
  status: 'Active',
);

/// Featured student used in the "Mock Data Example" spec (Aarav Sharma).
final Student featuredStudent = mockStudents.firstWhere(
  (s) => s.name == 'Aarav Sharma',
  orElse: () => const Student(
    id: 'stu-featured-aarav',
    name: 'Aarav Sharma',
    rollNumber: 'CSE23041',
    department: 'Computer Science',
    departmentId: 'dept-cse',
    year: 'III',
    attendancePercent: 91.0,
    email: 'aarav.sharma@example.edu',
    phone: '+1 555 123 4567',
  ),
);

List<Student> studentsByDepartment(String departmentId) =>
    mockStudents.where((s) => s.departmentId == departmentId).toList();

Student? studentById(String id) {
  try {
    return mockStudents.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
}
