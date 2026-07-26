import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app/app.dart';
import 'core/app_flavor.dart';

/// Default entry point (what plain `flutter run` / your IDE's Run button
/// uses). It auto-picks a flavor from the platform as a convenience for
/// local development: web -> Admin console, everything else -> Faculty &
/// Student app.
///
/// For an explicit, unambiguous build — e.g. what you'd actually deploy —
/// use one of the two dedicated entry points instead:
///   flutter run  -t lib/admin_main.dart          -d chrome
///   flutter run  -t lib/staff_student_main.dart  -d <android/ios device>
///   flutter build web  -t lib/admin_main.dart
///   flutter build apk  -t lib/staff_student_main.dart
void main() {
  usePathUrlStrategy();
  runApp(AttenceApp(flavor: kIsWeb ? AppFlavor.admin : AppFlavor.staffStudent));
}
