import 'package:flutter/material.dart';

/// Centralized color palette for the Attence app.
///
/// Follows the international SaaS design standard requested:
/// calm neutrals, a single confident primary, and restrained
/// semantic colors for status. No gradients, no neon.
class AppColors {
  AppColors._();

  // ---- Brand ----
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primarySurface = Color(0xFFEFF6FF);

  // ---- Light theme neutrals ----
  static const Color background = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color divider = Color(0xFFEEF1F5);
  static const Color hover = Color(0xFFF1F5F9);

  // ---- Dark theme neutrals ----
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color cardDark = Color(0xFF141B2D);
  static const Color borderDark = Color(0xFF232D42);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color hoverDark = Color(0xFF1B2438);

  // ---- Semantic ----
  static const Color success = Color(0xFF16A34A);
  static const Color successSurface = Color(0xFFF0FDF4);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSurface = Color(0xFFFFFBEB);
  static const Color error = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoSurface = Color(0xFFF0F9FF);

  // ---- Chart palette (muted, professional) ----
  static const List<Color> chartSeries = [
    Color(0xFF2563EB),
    Color(0xFF16A34A),
    Color(0xFFF59E0B),
    Color(0xFF9333EA),
    Color(0xFF0EA5E9),
    Color(0xFFDC2626),
    Color(0xFF64748B),
  ];

  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
      case 'active':
      case 'success':
      case 'completed':
        return success;
      case 'absent':
      case 'error':
      case 'inactive':
        return error;
      case 'late':
      case 'warning':
      case 'pending':
        return warning;
      default:
        return info;
    }
  }
}
