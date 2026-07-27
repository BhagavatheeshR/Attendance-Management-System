import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app/app.dart';
import 'core/app_flavor.dart';

/// Entry point for the Faculty & Student app build.
///
///   flutter run   -t lib/staff_student_main.dart -d <android/ios device>
///   flutter build apk -t lib/staff_student_main.dart
///   flutter build ios -t lib/staff_student_main.dart
///
/// This binary only ever shows Faculty and Student — the Admin routes are
/// compiled in but blocked by the router's redirect guard (see
/// `app/routes.dart`), and the login screen never offers that role.
void main() {
  // No-op off web; kept in case this flavor is ever also shipped as a web
  // build for staff/students.
  usePathUrlStrategy();
  runApp(const AttenceApp(flavor: AppFlavor.staffStudent));
}
