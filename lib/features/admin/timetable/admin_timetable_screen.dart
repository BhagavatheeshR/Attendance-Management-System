import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../mock/timetable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
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
                _Dropdown(
                  label: 'Department',
                  value: _departmentId,
                  items: {for (final d in mockDepartments) d.id: d.name},
                  onChanged: (v) => setState(() => _departmentId = v),
                ),
                _Dropdown(
                  label: 'Year',
                  value: _year,
                  items: const {'I': 'Year I', 'II': 'Year II', 'III': 'Year III', 'IV': 'Year IV'},
                  onChanged: (v) => setState(() => _year = v),
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
                InfoCard(
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 44,
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      SizedBox(
                        width: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.startTime, style: AppTextStyles.labelLg(primaryText)),
                            Text(entry.endTime, style: AppTextStyles.caption(secondaryText)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.subject, style: AppTextStyles.h3(primaryText)),
                            const SizedBox(height: 2),
                            Text('${entry.subjectCode} · ${entry.facultyName}', style: AppTextStyles.bodySm(secondaryText)),
                          ],
                        ),
                      ),
                      InfoChip(icon: Icons.meeting_room_outlined, label: entry.room),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown({required this.label, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.borderDark : AppColors.border;
    final fillColor = isDark ? AppColors.cardDark : AppColors.card;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          items: items.entries
              .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, style: AppTextStyles.bodyMd(textColor))))
              .toList(),
          onChanged: (v) => v == null ? null : onChanged(v),
        ),
      ),
    );
  }
}
