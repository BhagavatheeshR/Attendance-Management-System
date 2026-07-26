enum NotificationType { info, success, warning, error }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  final bool read;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.type = NotificationType.info,
    this.read = false,
  });
}
