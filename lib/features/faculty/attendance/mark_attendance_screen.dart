import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/attendance.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';

/// Roster-based attendance marking screen. Mock-only: toggling a student's
/// status updates local state and "Submit" shows a confirmation — no
/// backend write yet.
class MarkAttendanceScreen extends StatefulWidget {
  final String classId;
  const MarkAttendanceScreen({super.key, required this.classId});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  late Set<String> _absentIds = Set.from(currentSessionAbsentIds);
  String _query = '';
  bool _submitted = false;

  void _toggle(String id) {
    setState(() {
      if (_absentIds.contains(id)) {
        _absentIds.remove(id);
      } else {
        _absentIds.add(id);
      }
    });
  }

  Future<void> _submit() async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'Submit attendance?',
      message: '${currentSessionRoster.length - _absentIds.length} present · ${_absentIds.length} absent. This cannot be edited after submission.',
      confirmLabel: 'Submit',
    );
    if (confirmed && mounted) {
      setState(() => _submitted = true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance submitted successfully')));
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final roster = currentSessionRoster
        .where((s) => _query.isEmpty || s.name.toLowerCase().contains(_query.toLowerCase()) || s.rollNumber.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    final present = currentSessionRoster.length - _absentIds.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        title: const Text('Database Systems'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitted ? null : _submit,
        icon: const Icon(Icons.check_rounded),
        label: const Text('Submit Attendance'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.pagePadding(context).horizontal / 2,
              AppSpacing.md,
              Responsive.pagePadding(context).horizontal / 2,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CounterChip(label: 'Present', value: present, color: AppColors.success),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CounterChip(label: 'Absent', value: _absentIds.length, color: AppColors.error),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.pagePadding(context).horizontal / 2),
            child: AppSearchBar(hint: 'Search roll number or name…', onChanged: (v) => setState(() => _query = v)),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                Responsive.pagePadding(context).horizontal / 2,
                0,
                Responsive.pagePadding(context).horizontal / 2,
                96,
              ),
              itemCount: roster.length,
              itemBuilder: (context, i) {
                final s = roster[i];
                final isAbsent = _absentIds.contains(s.id);
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: InfoCard(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    onTap: () => _toggle(s.id),
                    child: Row(
                      children: [
                        ProfileAvatar(initials: s.initials, size: 36),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.name, style: AppTextStyles.labelLg(primaryText)),
                              Text(s.rollNumber, style: AppTextStyles.bodySm(secondaryText)),
                            ],
                          ),
                        ),
                        ChoiceChip(
                          label: Text(isAbsent ? 'Absent' : 'Present'),
                          selected: true,
                          selectedColor: (isAbsent ? AppColors.error : AppColors.success).withValues(alpha: 0.12),
                          labelStyle: AppTextStyles.labelMd(isAbsent ? AppColors.error : AppColors.success),
                          side: BorderSide(color: (isAbsent ? AppColors.error : AppColors.success).withValues(alpha: 0.3)),
                          showCheckmark: false,
                          onSelected: (_) => _toggle(s.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _CounterChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$value', style: AppTextStyles.h2(color)),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.bodySm(color)),
        ],
      ),
    );
  }
}
