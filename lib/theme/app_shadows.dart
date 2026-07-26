import 'package:flutter/material.dart';

/// Exactly three elevation levels, soft shadows only — no harsh drop
/// shadows anywhere in the app.
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> low = [
    BoxShadow(color: Color(0x0D0F172A), blurRadius: 4, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x140F172A), blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> high = [
    BoxShadow(color: Color(0x1F0F172A), blurRadius: 24, offset: Offset(0, 10)),
  ];

  // Dark theme shadows read against a near-black canvas, so they need to be
  // stronger/blacker to register at all — a naive inverted shadow all but
  // disappears on a dark surface.
  static const List<BoxShadow> lowDark = [
    BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> mediumDark = [
    BoxShadow(color: Color(0x40000000), blurRadius: 16, offset: Offset(0, 5)),
  ];

  static const List<BoxShadow> highDark = [
    BoxShadow(color: Color(0x52000000), blurRadius: 28, offset: Offset(0, 12)),
  ];

  static List<BoxShadow> resolveLow(bool isDark) => isDark ? lowDark : low;
  static List<BoxShadow> resolveMedium(bool isDark) => isDark ? mediumDark : medium;
  static List<BoxShadow> resolveHigh(bool isDark) => isDark ? highDark : high;
}
