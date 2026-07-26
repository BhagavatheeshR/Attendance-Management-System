import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/reports.dart';
import '../../../shared/widgets.dart';

class FacultyNotificationsScreen extends StatelessWidget {
  const FacultyNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Notifications', subtitle: 'Updates relevant to your classes'),
            if (facultyNotifications.isEmpty)
              const EmptyState(icon: Icons.notifications_off_outlined, title: 'All caught up', message: 'You have no new notifications.')
            else
              InfoCard(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [for (final n in facultyNotifications) NotificationTile(item: n)],
                ),
              ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
