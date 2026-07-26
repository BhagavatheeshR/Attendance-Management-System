import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

enum DeviceType { mobile, tablet, desktop }

/// Responsive helpers used across the app to switch between:
/// - Mobile: bottom navigation bar
/// - Tablet: navigation rail
/// - Desktop: collapsible sidebar + top app bar
class Responsive {
  Responsive._();

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppBreakpoints.tablet) return DeviceType.desktop;
    if (width >= AppBreakpoints.mobile) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isMobile(BuildContext context) => deviceType(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) => deviceType(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) => deviceType(context) == DeviceType.desktop;
  static bool isDesktopOrTablet(BuildContext context) => !isMobile(context);

  /// True on ultrawide monitors (>= 1920px) — content still centers with a
  /// wider cap rather than stretching every card edge-to-edge.
  static bool isUltrawide(BuildContext context) => MediaQuery.sizeOf(context).width >= AppBreakpoints.ultrawide;

  /// Number of grid columns for stat/card grids at the current width.
  static int gridColumns(BuildContext context) {
    if (isUltrawide(context)) return 6;
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 3;
      case DeviceType.desktop:
        return 4;
    }
  }

  /// Horizontal page padding that scales with screen size.
  static EdgeInsets pagePadding(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.lg);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xl);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.xxl, vertical: AppSpacing.xl);
    }
  }

  /// Wraps content with a max width and centers it on very large screens.
  static Widget centered({required BuildContext context, required Widget child}) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isUltrawide(context) ? AppSpacing.maxContentWidthUltrawide : AppSpacing.maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}
