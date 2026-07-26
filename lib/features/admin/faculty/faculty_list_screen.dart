import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive.dart';
import '../../../mock/departments.dart';
import '../../../mock/faculty.dart';
import '../../../models/faculty.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';
import '../../../shared/widgets.dart';
import 'add_faculty_sheet.dart';

class FacultyListScreen extends StatefulWidget {
  const FacultyListScreen({super.key});

  @override
  State<FacultyListScreen> createState() => _FacultyListScreenState();
}

class _FacultyListScreenState extends State<FacultyListScreen> {
  String? _departmentFilter;

  List<Faculty> get _filtered {
    return mockFaculty.where((f) {
      final matchesDept = _departmentFilter == null || f.departmentId == _departmentFilter;
      return matchesDept;
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
        heroTag: 'fab-add-faculty',
        onPressed: () => showAddFacultySheet(context),
        icon: const Icon(Icons.badge_outlined),
        label: const Text('Add Faculty'),
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
                InfoCard(child: Column(children: List.generate(6, (_) => const SkeletonListTile()))),
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
                SectionHeader(title: 'Faculty', subtitle: '${results.length} of ${mockFaculty.length} shown'),
                const SizedBox(height: AppSpacing.md),
                FilterBar(
                  searchHint: 'Search by name or employee ID…',
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
                const SizedBox(height: AppSpacing.lg),
                if (results.isEmpty)
                  const EmptyState(
                    icon: Icons.person_search_rounded,
                    title: 'No faculty found',
                    message: 'Try adjusting your search or filters.',
                  )
                else
                  EnterpriseDataTable<Faculty>(
                    items: results,
                    idOf: (f) => f.id,
                    searchableText: (f) => '${f.name} ${f.employeeId}',
                    searchHint: 'Search by name or employee ID…',
                    onRowTap: (f) => context.push('/admin/faculty/${f.id}'),
                    exportLabel: 'Export Faculty',
                    columns: [
                      EnterpriseColumn<Faculty>(
                        label: 'Faculty',
                        flex: 3,
                        sortValue: (f) => f.name,
                        cellBuilder: (context, f) => Row(
                          children: [
                            ProfileAvatar(initials: f.initials, size: 32),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(child: Text(f.name, style: AppTextStyles.labelLg(primaryText), overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      EnterpriseColumn<Faculty>(
                        label: 'Employee ID',
                        flex: 2,
                        sortValue: (f) => f.employeeId,
                        cellBuilder: (context, f) => Text(f.employeeId, style: AppTextStyles.bodySm(secondaryText)),
                      ),
                      EnterpriseColumn<Faculty>(
                        label: 'Department',
                        flex: 2,
                        sortValue: (f) => f.department,
                        cellBuilder: (context, f) => Text(f.department, style: AppTextStyles.bodySm(secondaryText), overflow: TextOverflow.ellipsis),
                      ),
                      EnterpriseColumn<Faculty>(
                        label: 'Designation',
                        flex: 2,
                        sortValue: (f) => f.designation,
                        cellBuilder: (context, f) => Text(f.designation, style: AppTextStyles.bodySm(secondaryText)),
                      ),
                      EnterpriseColumn<Faculty>(
                        label: 'Experience',
                        flex: 1,
                        sortValue: (f) => f.experienceYears,
                        cellBuilder: (context, f) => Text('${f.experienceYears} yrs', style: AppTextStyles.bodySm(secondaryText)),
                      ),
                      EnterpriseColumn<Faculty>(
                        label: '',
                        flex: 1,
                        alignment: Alignment.centerRight,
                        cellBuilder: (context, f) => ActionMenu(items: [
                          ActionMenuItem(label: 'View profile', icon: Icons.person_outline_rounded, onTap: () => context.push('/admin/faculty/${f.id}')),
                          ActionMenuItem(label: 'Edit', icon: Icons.edit_outlined, onTap: () {}),
                          ActionMenuItem(
                            label: 'Remove',
                            icon: Icons.delete_outline_rounded,
                            isDestructive: true,
                            onTap: () => showConfirmationDialog(
                              context: context,
                              title: 'Remove faculty?',
                              message: 'This will remove ${f.name} from the directory.',
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
