import '../models/event_item.dart';
import '../models/notification_item.dart';
import 'departments.dart';
import 'faculty.dart';
import 'students.dart';
import 'subjects.dart';
import 'timetable.dart';

/// KPI numbers shown on the Admin dashboard header — computed straight
/// from the generated datasets (250 students / 45 faculty / 12
/// departments / 35 subjects), so the headline stats always match what
/// the list screens actually contain.
int get totalStudents => mockStudents.length;
int get totalFaculty => mockFaculty.length;
int get totalDepartments => mockDepartments.length;
int get totalSubjects => mockSubjects.length;
int get activeClasses => mockTimetable.where((t) => t.day == todayName()).length;

final List<ActivityItem> recentActivity = [
  ActivityItem(
    id: 'act-1',
    title: 'New student enrolled',
    subtitle: 'Ananya Reddy joined Computer Science - Year I',
    time: DateTime.now().subtract(const Duration(minutes: 12)),
    icon: 'person_add',
  ),
  ActivityItem(
    id: 'act-2',
    title: 'Attendance report generated',
    subtitle: 'Weekly report for Electronics & Communication exported',
    time: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
    icon: 'description',
  ),
  ActivityItem(
    id: 'act-3',
    title: 'Timetable updated',
    subtitle: 'Mechanical Engineering - Year II schedule revised',
    time: DateTime.now().subtract(const Duration(hours: 3)),
    icon: 'event_note',
  ),
  ActivityItem(
    id: 'act-4',
    title: 'Faculty onboarded',
    subtitle: 'Dr. Nathan Bishop added to Information Technology',
    time: DateTime.now().subtract(const Duration(hours: 5)),
    icon: 'badge',
  ),
  ActivityItem(
    id: 'act-5',
    title: 'Low attendance alert',
    subtitle: '14 students in Civil Engineering fell below 75%',
    time: DateTime.now().subtract(const Duration(hours: 8)),
    icon: 'warning',
  ),
  ActivityItem(
    id: 'act-6',
    title: 'Department budget approved',
    subtitle: 'Biotechnology lab equipment request approved',
    time: DateTime.now().subtract(const Duration(days: 1)),
    icon: 'check_circle',
  ),
];

final List<EventItem> upcomingEvents = [
  EventItem(
    id: 'evt-1',
    title: 'Mid-Semester Examinations',
    location: 'All Departments',
    date: DateTime.now().add(const Duration(days: 3)),
    category: 'Exam',
  ),
  EventItem(
    id: 'evt-2',
    title: 'Annual Tech Symposium',
    location: 'Main Auditorium',
    date: DateTime.now().add(const Duration(days: 7)),
    category: 'Seminar',
  ),
  EventItem(
    id: 'evt-3',
    title: 'Faculty Development Program',
    location: 'Conference Hall B',
    date: DateTime.now().add(const Duration(days: 10)),
    category: 'Meeting',
  ),
  EventItem(
    id: 'evt-4',
    title: 'Inter-College Sports Meet',
    location: 'Sports Complex',
    date: DateTime.now().add(const Duration(days: 14)),
    category: 'Sports',
  ),
  EventItem(
    id: 'evt-5',
    title: 'Founders Day Holiday',
    location: 'Campus Wide',
    date: DateTime.now().add(const Duration(days: 21)),
    category: 'Holiday',
  ),
];

final List<NotificationItem> facultyNotifications = [
  NotificationItem(
    id: 'notif-f1',
    title: 'Attendance submission due',
    message: 'Submit today\'s Database Systems attendance by 5:00 PM.',
    time: DateTime.now().subtract(const Duration(minutes: 20)),
    type: NotificationType.warning,
  ),
  NotificationItem(
    id: 'notif-f2',
    title: 'Timetable change',
    message: 'Thursday\'s Computer Networks class moved to Room 214.',
    time: DateTime.now().subtract(const Duration(hours: 2)),
    type: NotificationType.info,
  ),
  NotificationItem(
    id: 'notif-f3',
    title: 'Report ready',
    message: 'Your monthly attendance report has been generated.',
    time: DateTime.now().subtract(const Duration(hours: 6)),
    type: NotificationType.success,
    read: true,
  ),
  NotificationItem(
    id: 'notif-f4',
    title: 'Low attendance flagged',
    message: '3 students in Operating Systems are below 75% attendance.',
    time: DateTime.now().subtract(const Duration(days: 1)),
    type: NotificationType.error,
    read: true,
  ),
  NotificationItem(
    id: 'notif-f5',
    title: 'Meeting reminder',
    message: 'Department review meeting tomorrow at 10:00 AM.',
    time: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    type: NotificationType.info,
    read: true,
  ),
];

final List<NotificationItem> studentAnnouncements = [
  NotificationItem(
    id: 'notif-s1',
    title: 'Assignment deadline extended',
    message: 'Database Systems assignment 3 due date moved to Friday.',
    time: DateTime.now().subtract(const Duration(minutes: 45)),
    type: NotificationType.info,
  ),
  NotificationItem(
    id: 'notif-s2',
    title: 'Attendance below threshold',
    message: 'Your attendance in Machine Learning is at 74% — attend the next 3 classes.',
    time: DateTime.now().subtract(const Duration(hours: 3)),
    type: NotificationType.warning,
  ),
  NotificationItem(
    id: 'notif-s3',
    title: 'Exam hall ticket available',
    message: 'Download your mid-semester hall ticket from the portal.',
    time: DateTime.now().subtract(const Duration(hours: 9)),
    type: NotificationType.success,
    read: true,
  ),
  NotificationItem(
    id: 'notif-s4',
    title: 'Library books due',
    message: '2 books are due for return by this weekend.',
    time: DateTime.now().subtract(const Duration(days: 1)),
    type: NotificationType.info,
    read: true,
  ),
  NotificationItem(
    id: 'notif-s5',
    title: 'Tech Symposium registration open',
    message: 'Register for the Annual Tech Symposium before Friday.',
    time: DateTime.now().subtract(const Duration(days: 2)),
    type: NotificationType.info,
    read: true,
  ),
];
