import 'package:flutter/material.dart';
import '../core/app_flavor.dart';
import '../core/constants.dart';
import '../theme/app_theme.dart';
import 'app_state.dart';
import 'routes.dart';

class AttenceApp extends StatefulWidget {
  final AppFlavor flavor;
  const AttenceApp({super.key, required this.flavor});

  @override
  State<AttenceApp> createState() => _AttenceAppState();
}

class _AttenceAppState extends State<AttenceApp> {
  final AppState _appState = AppState();
  late final _router = buildRouter(widget.flavor);

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
        routerConfig: _router,
      ),
    );
  }
}
