import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Month-grid calendar where each day is shaded by attendance percentage
/// (a heat map over a calendar layout) — used on Student/Faculty/Admin
/// attendance screens. Pass a map of day-of-month -> percent (0-100); days
/// not present are rendered as "no data".
class AttendanceCalendar extends StatelessWidget {
  final DateTime month;
  final Map<int, double> percentByDay;
  final ValueChanged<int>? onDayTap;

  const AttendanceCalendar({super.key, required this.month, required this.percentByDay, this.onDayTap});

  Color _colorFor(double? percent, bool isDark) {
    if (percent == null) return isDark ? AppColors.hoverDark : AppColors.hover;
    if (percent >= 95) return AppColors.success;
    if (percent >= 85) return AppColors.success.withValues(alpha: 0.65);
    if (percent >= 75) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = firstDay.weekday % 7; // Sunday-first grid

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final d in const ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
              Expanded(
                child: Center(child: Text(d, style: AppTextStyles.caption(secondaryText))),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4),
          itemCount: leadingBlanks + daysInMonth,
          itemBuilder: (context, index) {
            if (index < leadingBlanks) return const SizedBox.shrink();
            final day = index - leadingBlanks + 1;
            final percent = percentByDay[day];
            final bg = _colorFor(percent, isDark);
            final isTextLight = percent != null && percent >= 75;

            return InkWell(
              onTap: onDayTap == null ? null : () => onDayTap!(day),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              child: Container(
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppSpacing.radiusSm)),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: AppTextStyles.caption(isTextLight ? Colors.white : primaryText),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _legendDot(AppColors.success, '95%+'),
            const SizedBox(width: AppSpacing.md),
            _legendDot(AppColors.warning, '75-84%'),
            const SizedBox(width: AppSpacing.md),
            _legendDot(AppColors.error, '<75%'),
          ],
        ),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.caption(isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
        ],
      );
    });
  }
}
