/// Consistent spacing scale (4pt grid) used across the whole app.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const double radiusSm = 6;
  static const double radiusMd = 10;
  static const double radiusLg = 14;
  static const double radiusXl = 20;
  static const double radiusFull = 999;

  /// Max content width for desktop/tablet centered layouts.
  static const double maxContentWidth = 1280;
}

/// Responsive breakpoints (Material 3 / common SaaS breakpoints).
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}
