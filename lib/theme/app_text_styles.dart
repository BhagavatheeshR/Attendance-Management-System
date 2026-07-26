import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Professional type scale inspired by Stripe / Linear dashboards.
/// Uses the platform default (system) font for a native, fast-loading feel —
/// no custom font download required.
class AppTextStyles {
  AppTextStyles._();

  static const String _family = 'Inter';

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _family,
      fontFamilyFallback: const [
        '-apple-system',
        'Segoe UI',
        'Roboto',
        'Helvetica Neue',
        'Arial',
      ],
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display / page-level headings
  static TextStyle displayLg(Color c) =>
      _base(size: 32, weight: FontWeight.w700, color: c, height: 1.2, letterSpacing: -0.5);
  static TextStyle displayMd(Color c) =>
      _base(size: 26, weight: FontWeight.w700, color: c, height: 1.25, letterSpacing: -0.3);
  static TextStyle displaySm(Color c) =>
      _base(size: 22, weight: FontWeight.w700, color: c, height: 1.3, letterSpacing: -0.2);

  // Section / card headings
  static TextStyle h1(Color c) => _base(size: 20, weight: FontWeight.w600, color: c, height: 1.3);
  static TextStyle h2(Color c) => _base(size: 17, weight: FontWeight.w600, color: c, height: 1.3);
  static TextStyle h3(Color c) => _base(size: 15, weight: FontWeight.w600, color: c, height: 1.3);

  // Body
  static TextStyle bodyLg(Color c) => _base(size: 15, weight: FontWeight.w400, color: c, height: 1.5);
  static TextStyle bodyMd(Color c) => _base(size: 14, weight: FontWeight.w400, color: c, height: 1.5);
  static TextStyle bodySm(Color c) => _base(size: 13, weight: FontWeight.w400, color: c, height: 1.45);

  // Labels / captions
  static TextStyle labelLg(Color c) => _base(size: 14, weight: FontWeight.w600, color: c, height: 1.3);
  static TextStyle labelMd(Color c) => _base(size: 13, weight: FontWeight.w600, color: c, height: 1.3);
  static TextStyle caption(Color c) => _base(size: 12, weight: FontWeight.w500, color: c, height: 1.3);
  static TextStyle overline(Color c) => _base(
        size: 11,
        weight: FontWeight.w600,
        color: c,
        height: 1.3,
        letterSpacing: 0.6,
      );

  // Numeric stat display
  static TextStyle statValue(Color c) =>
      _base(size: 28, weight: FontWeight.w700, color: c, height: 1.1, letterSpacing: -0.5);
  static TextStyle statValueSm(Color c) =>
      _base(size: 20, weight: FontWeight.w700, color: c, height: 1.1, letterSpacing: -0.3);

  // Convenience: default (light theme, primary text) shorthands used widely.
  static TextStyle get title => h1(AppColors.textPrimary);
  static TextStyle get subtitle => bodyMd(AppColors.textSecondary);
}
