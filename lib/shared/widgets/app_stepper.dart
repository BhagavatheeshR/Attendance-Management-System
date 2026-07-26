import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// Horizontal numbered-step indicator for multi-step flows (e.g. student
/// enrollment wizard). Purely a progress indicator — pair with your own
/// page content per step.
class AppStepper extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const AppStepper({super.key, required this.steps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveBg = isDark ? AppColors.hoverDark : AppColors.hover;
    final inactiveText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final lineColor = isDark ? AppColors.borderDark : AppColors.border;

    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i <= currentStep ? AppColors.primary : inactiveBg,
                ),
                alignment: Alignment.center,
                child: i < currentStep
                    ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                    : Text('${i + 1}', style: AppTextStyles.labelMd(i == currentStep ? Colors.white : inactiveText)),
              ),
              const SizedBox(height: 6),
              Text(steps[i], style: AppTextStyles.caption(i <= currentStep ? AppColors.primary : inactiveText)),
            ],
          ),
          if (i != steps.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 18),
                color: i < currentStep ? AppColors.primary : lineColor,
              ),
            ),
        ],
      ],
    );
  }
}
