import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Thin banner shown at the top of a screen when connectivity is lost.
/// Purely presentational here — wire `visible` to a real connectivity
/// stream once this connects to a backend.
class OfflineBanner extends StatelessWidget {
  final bool visible;
  const OfflineBanner({super.key, this.visible = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: !visible
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              color: AppColors.warning,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 16, color: Colors.white),
                  const SizedBox(width: AppSpacing.sm),
                  Text('You\'re offline — showing the last synced data.', style: AppTextStyles.bodySm(Colors.white)),
                ],
              ),
            ),
    );
  }
}
