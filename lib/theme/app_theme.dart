import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// Builds the light and dark [ThemeData] for the app.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      surface: AppColors.card,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      splashFactory: InkRipple.splashFactory,
      dividerColor: AppColors.divider,
      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 1),
      fontFamily: 'Inter',
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLg(AppColors.textPrimary),
        displayMedium: AppTextStyles.displayMd(AppColors.textPrimary),
        displaySmall: AppTextStyles.displaySm(AppColors.textPrimary),
        headlineMedium: AppTextStyles.h1(AppColors.textPrimary),
        headlineSmall: AppTextStyles.h2(AppColors.textPrimary),
        titleMedium: AppTextStyles.h3(AppColors.textPrimary),
        bodyLarge: AppTextStyles.bodyLg(AppColors.textPrimary),
        bodyMedium: AppTextStyles.bodyMd(AppColors.textPrimary),
        bodySmall: AppTextStyles.bodySm(AppColors.textSecondary),
        labelLarge: AppTextStyles.labelLg(AppColors.textPrimary),
        labelMedium: AppTextStyles.labelMd(AppColors.textSecondary),
        labelSmall: AppTextStyles.caption(AppColors.textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.h1(AppColors.textPrimary),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 22),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.hover,
        selectedColor: AppColors.primarySurface,
        labelStyle: AppTextStyles.labelMd(AppColors.textPrimary),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.border,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: AppTextStyles.labelLg(Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: AppTextStyles.labelLg(AppColors.textPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.labelLg(AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        hintStyle: AppTextStyles.bodyMd(AppColors.textTertiary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.card,
        selectedIconTheme: const IconThemeData(color: AppColors.primary),
        unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary),
        selectedLabelTextStyle: AppTextStyles.labelMd(AppColors.primary),
        unselectedLabelTextStyle: AppTextStyles.labelMd(AppColors.textSecondary),
        indicatorColor: AppColors.primarySurface,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption(AppColors.primary),
        unselectedLabelStyle: AppTextStyles.caption(AppColors.textSecondary),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: AppTextStyles.caption(Colors.white),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.bodyMd(Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  static ThemeData dark() {
    final base = light();
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      surface: AppColors.cardDark,
      error: AppColors.error,
    );

    return base.copyWith(
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      canvasColor: AppColors.backgroundDark,
      dividerColor: AppColors.borderDark,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLg(AppColors.textPrimaryDark),
        displayMedium: AppTextStyles.displayMd(AppColors.textPrimaryDark),
        displaySmall: AppTextStyles.displaySm(AppColors.textPrimaryDark),
        headlineMedium: AppTextStyles.h1(AppColors.textPrimaryDark),
        headlineSmall: AppTextStyles.h2(AppColors.textPrimaryDark),
        titleMedium: AppTextStyles.h3(AppColors.textPrimaryDark),
        bodyLarge: AppTextStyles.bodyLg(AppColors.textPrimaryDark),
        bodyMedium: AppTextStyles.bodyMd(AppColors.textPrimaryDark),
        bodySmall: AppTextStyles.bodySm(AppColors.textSecondaryDark),
        labelLarge: AppTextStyles.labelLg(AppColors.textPrimaryDark),
        labelMedium: AppTextStyles.labelMd(AppColors.textSecondaryDark),
        labelSmall: AppTextStyles.caption(AppColors.textSecondaryDark),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.cardDark,
        foregroundColor: AppColors.textPrimaryDark,
        titleTextStyle: AppTextStyles.h1(AppColors.textPrimaryDark),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark, size: 22),
      ),
      cardTheme: base.cardTheme.copyWith(
        color: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.borderDark),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.hoverDark,
        side: const BorderSide(color: AppColors.borderDark),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
      ),
      navigationRailTheme: base.navigationRailTheme.copyWith(
        backgroundColor: AppColors.cardDark,
        unselectedIconTheme: const IconThemeData(color: AppColors.textSecondaryDark),
        unselectedLabelTextStyle: AppTextStyles.labelMd(AppColors.textSecondaryDark),
        indicatorColor: AppColors.primary.withValues(alpha: 0.18),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: AppColors.cardDark,
        unselectedItemColor: AppColors.textSecondaryDark,
      ),
      popupMenuTheme: base.popupMenuTheme.copyWith(
        color: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.borderDark),
        ),
      ),
      dialogTheme: base.dialogTheme.copyWith(backgroundColor: AppColors.cardDark),
    );
  }
}
