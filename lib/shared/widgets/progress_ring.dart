import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Standalone circular progress indicator with an animated fill and
/// centered percentage label — the same visual used inside AttendanceCard,
/// extracted so it can be reused anywhere (analytics cards, profile
/// headers, department summaries).
class ProgressRing extends StatelessWidget {
  final double percent;
  final double size;
  final double strokeWidth;
  final Color? color;
  final String? centerLabel;

  const ProgressRing({
    super.key,
    required this.percent,
    this.size = 64,
    this.strokeWidth = 6,
    this.color,
    this.centerLabel,
  });

  Color _autoColor() {
    if (percent >= 90) return AppColors.success;
    if (percent >= 75) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ringColor = color ?? _autoColor();
    final track = isDark ? AppColors.hoverDark : AppColors.hover;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: (percent / 100).clamp(0, 1)),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => CircularProgressIndicator(
              value: value,
              strokeWidth: strokeWidth,
              backgroundColor: track,
              valueColor: AlwaysStoppedAnimation(ringColor),
            ),
          ),
          Text(
            centerLabel ?? '${percent.toStringAsFixed(0)}%',
            style: AppTextStyles.statValueSm(textColor).copyWith(fontSize: size * 0.28),
          ),
        ],
      ),
    );
  }
}
