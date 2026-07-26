import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';

/// Trend direction for the small delta indicator on a [StatCard].
enum StatTrend { up, down, flat }

/// KPI tile used across dashboards — big number, label, icon, optional trend.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? accentColor;
  final String? trendLabel;
  final StatTrend trend;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accentColor,
    this.trendLabel,
    this.trend = StatTrend.flat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final accent = accentColor ?? AppColors.primary;

    return InfoCard(
      onTap: onTap,
      enableHover: onTap != null,
      // The icon row is pinned to the top and the value/label pair is kept
      // tightly grouped together; the Spacer (rather than a fixed-height
      // gap) absorbs whatever room is left, so this never overflows a
      // tight grid cell even at narrow aspect ratios.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              if (trendLabel != null) _TrendPill(label: trendLabel!, trend: trend),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.statValue(primaryText)),
              const SizedBox(height: 2),
              Text(label, style: AppTextStyles.bodySm(secondaryText)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendPill extends StatelessWidget {
  final String label;
  final StatTrend trend;
  const _TrendPill({required this.label, required this.trend});

  @override
  Widget build(BuildContext context) {
    final color = trend == StatTrend.up
        ? AppColors.success
        : trend == StatTrend.down
            ? AppColors.error
            : AppColors.textSecondary;
    final icon = trend == StatTrend.up
        ? Icons.arrow_upward_rounded
        : trend == StatTrend.down
            ? Icons.arrow_downward_rounded
            : Icons.remove_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 2),
          Text(label, style: AppTextStyles.caption(color)),
        ],
      ),
    );
  }
}
