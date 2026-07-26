import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../mock/students.dart';
import '../../../models/student.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';
import 'add_student_sheet.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String? _departmentFilter;
  String? _yearFilter;

  List<Student> get _filtered {
    return mockStudents.where((s) {
      final matchesDept = _departmentFilter == null || s.departmentId == _departmentFilter;
      final matchesYear = _yearFilter == null || s.year == _yearFilter;
      return matchesDept && matchesYear;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final results = _filtered;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        // Several of these FABs live in branches of the same
        // StatefulShellRoute IndexedStack, so they're mounted
        // simultaneously — each needs its own hero tag (or none) to avoid
        // "multiple heroes share the same tag" during page transitions.
        heroTag: 'fab-add-student',
        onPressed: () => showAddStudentSheet(context),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add Student'),
      ),
      body: LoadingGate(
        skeleton: SingleChildScrollView(
          padding: Responsive.pagePadding(context),
          physics: const NeverScrollableScrollPhysics(),
          child: Responsive.centered(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoadingSkeleton(width: 160, height: 24),
                const SizedBox(height: AppSpacing.lg),
                const LoadingSkeleton(height: 44, borderRadius: AppSpacing.radiusMd),
                const SizedBox(height: AppSpacing.lg),
                InfoCard(child: Column(children: List.generate(8, (_) => const SkeletonListTile()))),
              ],
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: Responsive.pagePadding(context),
          child: Responsive.centered(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(title: 'Students', subtitle: '${results.length} of ${mockStudents.length} shown'),
                const SizedBox(height: AppSpacing.md),
                FilterBar(
                  searchHint: 'Search by name or roll number…',
                  filters: [
                    FilterBarOption(
                      label: 'All Departments',
                      selected: _departmentFilter == null,
                      onSelected: () => setState(() => _departmentFilter = null),
                    ),
                    for (final dept in mockDepartments)
                      FilterBarOption(
                        label: dept.code,
                        selected: _departmentFilter == dept.id,
                        onSelected: () => setState(() => _departmentFilter = _departmentFilter == dept.id ? null : dept.id),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final year in ['I', 'II', 'III', 'IV'])
                      AppFilterChip(
                        label: 'Year $year',
                        selected: _yearFilter == year,
                        onSelected: (_) => setState(() => _yearFilter = _yearFilter == year ? null : year),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                if (results.isEmpty)
                  const EmptyState(
                    icon: Icons.person_search_rounded,
                    title: 'No students found',
                    message: 'Try adjusting your search or filters.',
                  )
                else
                  EnterpriseDataTable<Student>(
                    items: results,
                    idOf: (s) => s.id,
                    searchableText: (s) => '${s.name} ${s.rollNumber}',
                    searchHint: 'Search by name or roll number…',
                    onRowTap: (s) => context.push('/admin/students/${s.id}'),
                    exportLabel: 'Export Students',
                    columns: [
                      EnterpriseColumn<Student>(
                        label: 'Student',
                        flex: 3,
                        sortValue: (s) => s.name,
                        cellBuilder: (context, s) => Row(
                          children: [
                            ProfileAvatar(initials: s.initials, size: 32),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(child: Text(s.name, style: AppTextStyles.labelLg(primaryText), overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      EnterpriseColumn<Student>(
                        label: 'Roll No.',
                        flex: 2,
                        sortValue: (s) => s.rollNumber,
                        cellBuilder: (context, s) => Text(s.rollNumber, style: AppTextStyles.bodySm(secondaryText)),
                      ),
                      EnterpriseColumn<Student>(
                        label: 'Department',
                        flex: 2,
                        sortValue: (s) => s.department,
                        cellBuilder: (context, s) => Text(s.department, style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis),
                      ),
                      EnterpriseColumn<Student>(
                        label: 'Year',
                        flex: 1,
                        sortValue: (s) => s.year,
                        cellBuilder: (context, s) => Text('Year ${s.year}', style: AppTextStyles.bodySm(secondaryText)),
                      ),
                      EnterpriseColumn<Student>(
                        label: 'Attendance',
                        flex: 2,
                        sortValue: (s) => s.attendancePercent,
                        cellBuilder: (context, s) => Text(
                          '${s.attendancePercent.toStringAsFixed(1)}%',
                          style: AppTextStyles.labelMd(
                            s.attendancePercent >= 90 ? AppColors.success : s.attendancePercent >= 75 ? AppColors.warning : AppColors.error,
                          ),
                        ),
                      ),
                      EnterpriseColumn<Student>(
                        label: 'Status',
                        flex: 2,
                        sortValue: (s) => s.status,
                        cellBuilder: (context, s) => StatusBadge(label: s.status),
                      ),
                      EnterpriseColumn<Student>(
                        label: '',
                        flex: 1,
                        alignment: Alignment.centerRight,
                        cellBuilder: (context, s) => ActionMenu(items: [
                          ActionMenuItem(label: 'View profile', icon: Icons.person_outline_rounded, onTap: () => context.push('/admin/students/${s.id}')),
                          ActionMenuItem(label: 'Edit', icon: Icons.edit_outlined, onTap: () {}),
                          ActionMenuItem(
                            label: 'Remove',
                            icon: Icons.delete_outline_rounded,
                            isDestructive: true,
                            onTap: () => showConfirmationDialog(
                              context: context,
                              title: 'Remove student?',
                              message: 'This will remove ${s.name} from the roster.',
                              isDestructive: true,
                              confirmLabel: 'Remove',
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
