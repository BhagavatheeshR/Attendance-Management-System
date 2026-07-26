import 'package:flutter/material.dart';

/// Shows [skeleton] for a short simulated delay, then cross-fades into
/// [child]. This is what a real network-backed screen would do while
/// waiting on its first repository call — wired here against mock data so
/// the shimmer/skeleton pattern is visible even though the data is local.
class LoadingGate extends StatefulWidget {
  final Widget skeleton;
  final Widget child;
  final Duration delay;

  const LoadingGate({
    super.key,
    required this.skeleton,
    required this.child,
    this.delay = const Duration(milliseconds: 650),
  });

  @override
  State<LoadingGate> createState() => _LoadingGateState();
}

class _LoadingGateState extends State<LoadingGate> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _ready ? KeyedSubtree(key: const ValueKey('content'), child: widget.child) : KeyedSubtree(key: const ValueKey('skeleton'), child: widget.skeleton),
    );
  }
}
