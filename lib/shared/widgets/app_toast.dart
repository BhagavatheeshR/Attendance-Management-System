import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

enum ToastType { success, error, info, warning }

/// Lightweight, auto-dismissing overlay toast — distinct from [SnackBar]
/// (which docks to the Scaffold bottom and queues); a toast floats over
/// the current screen and stacks independently. Use for quick, low-stakes
/// confirmations ("Copied", "Saved").
void showAppToast(BuildContext context, String message, {ToastType type = ToastType.success}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  late final OverlayEntry entry;

  final color = switch (type) {
    ToastType.success => AppColors.success,
    ToastType.error => AppColors.error,
    ToastType.info => AppColors.info,
    ToastType.warning => AppColors.warning,
  };
  final icon = switch (type) {
    ToastType.success => Icons.check_circle_rounded,
    ToastType.error => Icons.error_rounded,
    ToastType.info => Icons.info_rounded,
    ToastType.warning => Icons.warning_rounded,
  };

  entry = OverlayEntry(
    builder: (context) => _ToastWidget(
      message: message,
      color: color,
      icon: icon,
      onDismissed: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismissed;

  const _ToastWidget({required this.message, required this.color, required this.icon, required this.onDismissed});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 220))..forward();
    Future.delayed(const Duration(seconds: 2, milliseconds: 400), () async {
      if (!mounted) return;
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: Center(
        child: FadeTransition(
          opacity: _controller,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.3), end: Offset.zero)
                .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: widget.color.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.icon, size: 18, color: widget.color),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(child: Text(widget.message, style: AppTextStyles.bodyMd(Colors.white))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
