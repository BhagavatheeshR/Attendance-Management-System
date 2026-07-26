import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ActionMenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const ActionMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}

/// Overflow ("…") menu used on table rows and cards for row-level actions.
class ActionMenu extends StatelessWidget {
  final List<ActionMenuItem> items;
  final IconData icon;

  const ActionMenu({super.key, required this.items, this.icon = Icons.more_horiz_rounded});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return PopupMenuButton<int>(
      icon: Icon(icon, color: iconColor, size: 20),
      splashRadius: 18,
      onSelected: (i) => items[i].onTap(),
      itemBuilder: (context) => List.generate(items.length, (i) {
        final item = items[i];
        final color = item.isDestructive ? AppColors.error : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary);
        return PopupMenuItem<int>(
          value: i,
          child: Row(
            children: [
              Icon(item.icon, size: 17, color: color),
              const SizedBox(width: 10),
              Text(item.label, style: AppTextStyles.bodyMd(color)),
            ],
          ),
        );
      }),
    );
  }
}
