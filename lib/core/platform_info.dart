import 'package:flutter/foundation.dart' show kIsWeb;

/// Central place for the "web = Admin console, app = Faculty/Student"
/// product rule. Only one flag matters here (kIsWeb) since it's reliable
/// on every platform Flutter targets, including build-time web renders.
class PlatformInfo {
  PlatformInfo._();

  /// True when running as a web build (the Admin console).
  static bool get isWeb => kIsWeb;

  /// True when running as a native app build — Android, iOS, or desktop
  /// (the Faculty/Student experience).
  static bool get isApp => !kIsWeb;
}
