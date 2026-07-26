import 'package:flutter/material.dart';

/// Centralized color palette for the Attence app — international
/// enterprise SaaS standard (Microsoft 365 / Stripe / Notion / Linear).
/// No gradients, no neon; calm neutrals with one confident primary and a
/// restrained semantic set for status.
class AppColors {
  AppColors._();

  // ---- Brand ----
  static const Color primary = Color(0xFF2563EB); // Royal Blue
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primarySurface = Color(0xFFEFF6FF);
  static const Color secondary = Color(0xFF334155); // Slate

  // ---- Light theme surfaces ----
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = surface; // alias — one reusable card surface
  static const Color surfaceSecondary = Color(0xFFF1F5F9);
  static const Color hover = surfaceSecondary; // alias, used pre-existing widgets
  static const Color divider = Color(0xFFE2E8F0);
  static const Color border = divider; // alias — one hairline color everywhere

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // ---- Dark theme — a genuinely separate palette, not inverted light ----
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color surfaceDark = Color(0xFF141B2D);
  static const Color cardDark = surfaceDark;
  static const Color surfaceSecondaryDark = Color(0xFF1B2438);
  static const Color hoverDark = surfaceSecondaryDark;
  static const Color borderDark = Color(0xFF232D42);
  static const Color dividerDark = borderDark;
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // ---- Semantic ----
  static const Color success = Color(0xFF22C55E);
  static const Color successSurface = Color(0xFFF0FDF4);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSurface = Color(0xFFFFFBEB);
  static const Color error = Color(0xFFEF4444);
  static const Color errorSurface = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF06B6D4);
  static const Color infoSurface = Color(0xFFECFEFF);

  // ---- Chart palette (muted, professional) ----
  static const List<Color> chartSeries = [
    Color(0xFF2563EB),
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFF9333EA),
    Color(0xFF06B6D4),
    Color(0xFFEF4444),
    Color(0xFF334155),
  ];

  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
      case 'active':
      case 'success':
      case 'completed':
      case 'approved':
        return success;
      case 'absent':
      case 'error':
      case 'inactive':
      case 'rejected':
      case 'failed':
        return error;
      case 'late':
      case 'warning':
      case 'pending':
      case 'at risk':
        return warning;
      default:
        return info;
    }
  }
}
