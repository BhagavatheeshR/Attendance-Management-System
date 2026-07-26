import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import 'filter_chip_widget.dart';
import 'search_bar_widget.dart';

class FilterBarOption {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const FilterBarOption({required this.label, required this.selected, required this.onSelected});
}

/// Combines a search field with a horizontally scrolling row of filter
/// chips — the standard header for every list/table screen.
class FilterBar extends StatelessWidget {
  final String searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<FilterBarOption> filters;
  final Widget? trailing;

  const FilterBar({
    super.key,
    this.searchHint = 'Search…',
    this.onSearchChanged,
    this.filters = const [],
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: AppSearchBar(hint: searchHint, onChanged: onSearchChanged)),
            if (trailing != null) ...[const SizedBox(width: AppSpacing.sm), trailing!],
          ],
        ),
        if (filters.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) => AppFilterChip(
                label: filters[i].label,
                selected: filters[i].selected,
                onSelected: (_) => filters[i].onSelected(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
