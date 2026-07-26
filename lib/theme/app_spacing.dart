/// Consistent spacing scale — never random spacing. Every gap in the app
/// uses one of: 4, 8, 12, 16, 20, 24, 32, 40, 48, 64.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double lg2 = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxl2 = 40;
  static const double xxxl = 48;
  static const double huge = 64;

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 999;

  /// Max content width for desktop/tablet centered layouts.
  static const double maxContentWidth = 1280;

  /// Max content width on ultrawide monitors — content still centers with
  /// generous margins rather than stretching edge-to-edge.
  static const double maxContentWidthUltrawide = 1600;
}

/// Responsive breakpoints (Material 3 / common SaaS breakpoints).
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
  static const double ultrawide = 1920;
}
