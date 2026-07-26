import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../theme/app_theme.dart';
import 'app_state.dart';
import 'routes.dart';

class AttenceApp extends StatefulWidget {
  const AttenceApp({super.key});

  @override
  State<AttenceApp> createState() => _AttenceAppState();
}

class _AttenceAppState extends State<AttenceApp> {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    _appState.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: _appState,
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: _appState.themeMode,
        routerConfig: appRouter,
      ),
    );
  }
}
