import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'app_data_table.dart';
import 'app_toast.dart';
import 'empty_state.dart';
import 'search_bar_widget.dart';

/// One column definition for [EnterpriseDataTable].
class EnterpriseColumn<T> {
  final String label;
  final int flex;
  final Widget Function(BuildContext context, T item) cellBuilder;
  final Comparable Function(T item)? sortValue;
  final bool defaultVisible;
  final Alignment alignment;

  const EnterpriseColumn({
    required this.label,
    required this.cellBuilder,
    this.flex = 1,
    this.sortValue,
    this.defaultVisible = true,
    this.alignment = Alignment.centerLeft,
  });
}

/// Full "enterprise" data table: search, sort, pagination, bulk select,
/// column visibility, and export — built on top of the presentational
/// [AppDataTable]. This is what every Student/Faculty/Reports list screen
/// should use instead of a bare table.
class EnterpriseDataTable<T> extends StatefulWidget {
  final List<T> items;
  final List<EnterpriseColumn<T>> columns;
  final String Function(T item) idOf;
  final String Function(T item) searchableText;
  final void Function(T item)? onRowTap;
  final String searchHint;
  final List<int> pageSizeOptions;
  final String exportLabel;
  final VoidCallback? onExport;

  const EnterpriseDataTable({
    super.key,
    required this.items,
    required this.columns,
    required this.idOf,
    required this.searchableText,
    this.onRowTap,
    this.searchHint = 'Search…',
    this.pageSizeOptions = const [10, 25, 50],
    this.exportLabel = 'Export CSV',
    this.onExport,
  });

  @override
  State<EnterpriseDataTable<T>> createState() => _EnterpriseDataTableState<T>();
}

class _EnterpriseDataTableState<T> extends State<EnterpriseDataTable<T>> {
  String _query = '';
  int? _sortColumn;
  bool _sortAscending = true;
  late Set<int> _visibleColumns = {
    for (int i = 0; i < widget.columns.length; i++)
      if (widget.columns[i].defaultVisible) i,
  };
  final Set<String> _selectedIds = {};
  int _page = 0;
  late int _pageSize = widget.pageSizeOptions.first;

  List<T> get _filteredSorted {
    var list = widget.items.where((item) {
      if (_query.isEmpty) return true;
      return widget.searchableText(item).toLowerCase().contains(_query.toLowerCase());
    }).toList();

    if (_sortColumn != null) {
      final sortFn = widget.columns[_sortColumn!].sortValue;
      if (sortFn != null) {
        list.sort((a, b) => sortFn(a).compareTo(sortFn(b)));
        if (!_sortAscending) list = list.reversed.toList();
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    final filtered = _filteredSorted;
    final totalPages = filtered.isEmpty ? 1 : (filtered.length / _pageSize).ceil();
    final safePage = _page.clamp(0, totalPages - 1);
    final pageItems = filtered.skip(safePage * _pageSize).take(_pageSize).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppSearchBar(
                hint: widget.searchHint,
                onChanged: (v) => setState(() {
                  _query = v;
                  _page = 0;
                }),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _ColumnVisibilityButton(
              columns: widget.columns,
              visible: _visibleColumns,
              onChanged: (i) => setState(() {
                if (_visibleColumns.contains(i)) {
                  if (_visibleColumns.length > 1) _visibleColumns.remove(i);
                } else {
                  _visibleColumns.add(i);
                }
              }),
            ),
            const SizedBox(width: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: widget.onExport ?? () => showAppToast(context, 'Preparing ${widget.exportLabel}…'),
              icon: const Icon(Icons.file_download_outlined, size: 17),
              label: Text(widget.exportLabel),
            ),
          ],
        ),
        if (_selectedIds.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text('${_selectedIds.length} selected', style: AppTextStyles.labelMd(AppColors.primary)),
                const Spacer(),
                TextButton(
                  onPressed: () => showAppToast(context, 'Exporting ${_selectedIds.length} selected rows…'),
                  child: const Text('Export selected'),
                ),
                TextButton(
                  onPressed: () => setState(_selectedIds.clear),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (pageItems.isEmpty)
          const EmptyState(icon: Icons.search_off_rounded, title: 'No results', message: 'Try a different search term.')
        else
          AppDataTable(
            columns: [
              const AppDataColumn(label: '', flex: 1),
              for (int i = 0; i < widget.columns.length; i++)
                if (_visibleColumns.contains(i))
                  AppDataColumn(label: widget.columns[i].label, flex: widget.columns[i].flex, alignment: widget.columns[i].alignment),
            ],
            rows: [
              for (final item in pageItems)
                AppDataRow(
                  onTap: widget.onRowTap == null ? null : () => widget.onRowTap!(item),
                  cells: [
                    Checkbox(
                      value: _selectedIds.contains(widget.idOf(item)),
                      onChanged: (v) => setState(() {
                        final id = widget.idOf(item);
                        if (v == true) {
                          _selectedIds.add(id);
                        } else {
                          _selectedIds.remove(id);
                        }
                      }),
                    ),
                    for (int i = 0; i < widget.columns.length; i++)
                      if (_visibleColumns.contains(i)) widget.columns[i].cellBuilder(context, item),
                  ],
                ),
            ],
          ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Text('Rows per page', style: AppTextStyles.bodySm(secondaryText)),
            const SizedBox(width: AppSpacing.sm),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _pageSize,
                isDense: true,
                items: widget.pageSizeOptions
                    .map((n) => DropdownMenuItem(value: n, child: Text('$n', style: AppTextStyles.bodySm(primaryText))))
                    .toList(),
                onChanged: (v) => setState(() {
                  if (v != null) _pageSize = v;
                  _page = 0;
                }),
              ),
            ),
            const Spacer(),
            Text(
              filtered.isEmpty
                  ? '0 of 0'
                  : '${safePage * _pageSize + 1}-${(safePage * _pageSize + pageItems.length)} of ${filtered.length}',
              style: AppTextStyles.bodySm(secondaryText),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: safePage > 0 ? () => setState(() => _page = safePage - 1) : null,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: safePage < totalPages - 1 ? () => setState(() => _page = safePage + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _ColumnVisibilityButton<T> extends StatelessWidget {
  final List<EnterpriseColumn<T>> columns;
  final Set<int> visible;
  final ValueChanged<int> onChanged;

  const _ColumnVisibilityButton({required this.columns, required this.visible, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: 'Column visibility',
      icon: const Icon(Icons.view_column_outlined),
      itemBuilder: (context) => [
        for (int i = 0; i < columns.length; i++)
          CheckedPopupMenuItem<int>(value: i, checked: visible.contains(i), child: Text(columns[i].label)),
      ],
      onSelected: onChanged,
    );
  }
}
