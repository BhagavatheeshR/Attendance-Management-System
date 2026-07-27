import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_spacing.dart';
import '../../../shared/widgets.dart';

class StudentTimetableScreen extends StatefulWidget {
  const StudentTimetableScreen({super.key});

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  String _day = todayName() == 'Sunday' ? 'Monday' : todayName();

  @override
  Widget build(BuildContext context) {
    final entries = timetableForDay(departmentId: 'dept-cse', year: 'III', day: _day);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Timetable', subtitle: 'Computer Science · Year III'),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final d in weekDays) ...[
                    AppFilterChip(label: d.substring(0, 3), selected: _day == d, onSelected: (_) => setState(() => _day = d)),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (entries.isEmpty)
              const EmptyState(icon: Icons.event_busy_rounded, title: 'No classes', message: 'No classes scheduled for this day.')
            else
              for (final entry in entries) ...[
                TimetableCard(entry: entry),
                const SizedBox(height: AppSpacing.sm),
              ],
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}
