import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app/app.dart';
import 'core/app_flavor.dart';

/// Entry point for the Admin console build.
///
///   flutter run   -t lib/admin_main.dart -d chrome
///   flutter build web -t lib/admin_main.dart
///
/// This binary only ever shows the Administrator role and portal — the
/// Faculty/Student routes are compiled in but blocked by the router's
/// redirect guard (see `app/routes.dart`), and the login screen never
/// offers them.
void main() {
  usePathUrlStrategy();
  runApp(const AttenceApp(flavor: AppFlavor.admin));
}
