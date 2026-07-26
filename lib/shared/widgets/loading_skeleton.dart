import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Shimmering placeholder block — used while mock/async data "loads".
class LoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const LoadingSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = AppSpacing.radiusSm,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.hoverDark : AppColors.hover;
    final highlight = isDark ? AppColors.borderDark : AppColors.border;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      period: const Duration(milliseconds: 1400),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// A skeleton placeholder shaped like a StatCard, for dashboard loading states.
class SkeletonStatCard extends StatelessWidget {
  const SkeletonStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
      ),
      // Distribute with spaceBetween (rather than fixed-height gaps) so this
      // never overflows: it only ever needs the sum of the three
      // placeholders' own heights (68px), and adapts to whatever room the
      // surrounding grid cell actually gives it.
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LoadingSkeleton(width: 32, height: 32, borderRadius: AppSpacing.radiusMd),
          LoadingSkeleton(width: 80, height: 24),
          LoadingSkeleton(width: 100, height: 12),
        ],
      ),
    );
  }
}

/// A skeleton placeholder shaped like a list row (student/faculty tiles).
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: const [
          LoadingSkeleton(width: 40, height: 40, borderRadius: AppSpacing.radiusFull),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(width: 140, height: 14),
                SizedBox(height: 6),
                LoadingSkeleton(width: 90, height: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
