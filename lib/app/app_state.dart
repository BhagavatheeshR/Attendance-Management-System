import 'package:flutter/material.dart';
import '../core/constants.dart';

/// Tiny app-wide session/theme controller. Kept dependency-free (no
/// provider/riverpod) so the mock-data phase stays simple; swapping this
/// for a real auth-backed controller later is a one-file change.
class AppState extends ChangeNotifier {
  UserRole? _currentRole;
  ThemeMode _themeMode = ThemeMode.light;
  String _displayName = 'Administrator';

  UserRole? get currentRole => _currentRole;
  ThemeMode get themeMode => _themeMode;
  String get displayName => _displayName;
  bool get isLoggedIn => _currentRole != null;

  void login(UserRole role, {String? name}) {
    _currentRole = role;
    _displayName = name ?? _defaultNameFor(role);
    notifyListeners();
  }

  void logout() {
    _currentRole = null;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  String _defaultNameFor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.faculty:
        return 'Dr. Emily Carter';
      case UserRole.student:
        return 'Sarathy';
    }
  }
}

/// Inherited access point: `AppStateScope.of(context)`.
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required AppState state, required super.child}) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.notifier!;
  }
}
