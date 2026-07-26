import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Circular avatar showing initials over a deterministic pastel background,
/// used for students, faculty, and the signed-in profile.
class ProfileAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color? backgroundColor;
  final bool showStatusDot;
  final Color statusColor;

  const ProfileAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.backgroundColor,
    this.showStatusDot = false,
    this.statusColor = AppColors.success,
  });

  static const List<Color> _palette = [
    Color(0xFFDBEAFE),
    Color(0xFFDCFCE7),
    Color(0xFFFEF3C7),
    Color(0xFFFCE7F3),
    Color(0xFFE0E7FF),
    Color(0xFFD1FAE5),
    Color(0xFFFFE4E6),
  ];

  static const List<Color> _fgPalette = [
    Color(0xFF1D4ED8),
    Color(0xFF15803D),
    Color(0xFFB45309),
    Color(0xFFBE185D),
    Color(0xFF4338CA),
    Color(0xFF047857),
    Color(0xFFBE123C),
  ];

  @override
  Widget build(BuildContext context) {
    final idx = initials.codeUnits.fold<int>(0, (a, b) => a + b) % _palette.length;
    final bg = backgroundColor ?? _palette[idx];
    final fg = _fgPalette[idx];

    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: AppTextStyles.labelLg(fg).copyWith(fontSize: size * 0.38, fontWeight: FontWeight.w700),
      ),
    );

    if (!showStatusDot) return avatar;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: size * 0.28,
            height: size * 0.28,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
