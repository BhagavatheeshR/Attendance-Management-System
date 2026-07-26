import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/reports.dart';
import '../../../shared/widgets.dart';

class StudentAnnouncementsScreen extends StatelessWidget {
  const StudentAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Announcements', subtitle: 'Updates from your department and faculty'),
            if (studentAnnouncements.isEmpty)
              const EmptyState(icon: Icons.campaign_outlined, title: 'No announcements', message: 'Check back later for updates.')
            else
              InfoCard(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [for (final n in studentAnnouncements) NotificationTile(item: n)],
                ),
              ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
