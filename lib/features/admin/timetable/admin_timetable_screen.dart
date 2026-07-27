import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_spacing.dart';
import '../../../shared/widgets.dart';

class AdminTimetableScreen extends StatefulWidget {
  const AdminTimetableScreen({super.key});

  @override
  State<AdminTimetableScreen> createState() => _AdminTimetableScreenState();
}

class _AdminTimetableScreenState extends State<AdminTimetableScreen> {
  String _departmentId = 'dept-cse';
  String _year = 'III';
  String _day = todayName() == 'Sunday' ? 'Monday' : todayName();

  @override
  Widget build(BuildContext context) {
    final entries = timetableForDay(departmentId: _departmentId, year: _year, day: _day);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Responsive.centered(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Timetable',
              subtitle: 'View and manage class schedules across departments',
              action: PrimaryButton(
                label: 'Create Timetable',
                icon: Icons.add_rounded,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Timetable builder coming soon')),
                ),
              ),
            ),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  child: AppDropdown<String>(
                    label: 'Department',
                    value: _departmentId,
                    items: {for (final d in mockDepartments) d.id: d.name},
                    onChanged: (v) => setState(() => _departmentId = v),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: AppDropdown<String>(
                    label: 'Year',
                    value: _year,
                    items: const {'I': 'Year I', 'II': 'Year II', 'III': 'Year III', 'IV': 'Year IV'},
                    onChanged: (v) => setState(() => _year = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
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
              const EmptyState(
                icon: Icons.event_busy_rounded,
                title: 'No classes scheduled',
                message: 'There are no classes for this department, year, and day.',
              )
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
