import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Fade transition — used for top-level tab/shell switches.
CustomTransitionPage<T> fadePage<T>({required Widget child, required GoRouterState state}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child),
  );
}

/// Slide-from-right transition — used for pushed detail screens.
CustomTransitionPage<T> slidePage<T>({required Widget child, required GoRouterState state}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween(begin: const Offset(0.04, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child),
    ),
  );
}
