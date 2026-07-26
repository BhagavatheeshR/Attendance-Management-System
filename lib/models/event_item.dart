class EventItem {
  final String id;
  final String title;
  final String location;
  final DateTime date;
  final String category; // Exam, Holiday, Seminar, Meeting, Sports

  const EventItem({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.category,
  });
}

class ActivityItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime time;
  final String icon; // key mapped to IconData in UI layer

  const ActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
  });
}
