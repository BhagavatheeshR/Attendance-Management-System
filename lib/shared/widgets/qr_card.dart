import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'info_card.dart';

/// A QR-style ID/check-in card — the QR pattern is a deterministic painted
/// grid seeded from [data] (no camera-scannable payload; this is a visual
/// stand-in for a student/faculty ID card until a real QR package is
/// wired in).
class QRCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String data;

  const QRCard({super.key, required this.title, required this.subtitle, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InfoCard(
      child: Column(
        children: [
          Text(title, style: AppTextStyles.h2(primaryText)),
          const SizedBox(height: 2),
          Text(subtitle, style: AppTextStyles.bodySm(secondaryText)),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
            ),
            child: SizedBox(
              width: 140,
              height: 140,
              child: CustomPaint(painter: _QrPatternPainter(data)),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(data, style: AppTextStyles.caption(secondaryText)),
        ],
      ),
    );
  }
}

class _QrPatternPainter extends CustomPainter {
  final String seed;
  _QrPatternPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    const grid = 10;
    final cell = size.width / grid;
    final random = Random(seed.codeUnits.fold<int>(0, (a, b) => a + b));
    final paint = Paint()..color = AppColors.textPrimary;

    for (int y = 0; y < grid; y++) {
      for (int x = 0; x < grid; x++) {
        final isFinder = (x < 3 && y < 3) || (x >= grid - 3 && y < 3) || (x < 3 && y >= grid - 3);
        final fill = isFinder ? (x == 1 && y == 1) || x == 0 || x == 2 || y == 0 || y == 2 : random.nextBool();
        if (fill) {
          canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell - 1, cell - 1), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPatternPainter oldDelegate) => oldDelegate.seed != seed;
}
