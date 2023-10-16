// ---------- COLORS ----------

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'theme.dart';

abstract class ThemeColors {
  static bool get isDarkMode =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

  static Color get background =>
      isDarkMode ? DarkColorPalette.background : LightColorPalette.background;
  static Color get onBackground => isDarkMode
      ? DarkColorPalette.onBackground
      : LightColorPalette.onBackground;

  static Color get surface =>
      isDarkMode ? DarkColorPalette.surface : LightColorPalette.surface;
  static Color get onSurface =>
      isDarkMode ? DarkColorPalette.onSurface : LightColorPalette.onSurface;
  static Color get surfaceVariant => isDarkMode
      ? DarkColorPalette.surfaceVariant
      : LightColorPalette.surfaceVariant;
  static Color get onSurfaceVariant => isDarkMode
      ? DarkColorPalette.onSurfaceVariant
      : LightColorPalette.onSurfaceVariant;

  static Color get primary =>
      isDarkMode ? DarkColorPalette.primary : LightColorPalette.primary;
  static Color get onPrimary =>
      isDarkMode ? DarkColorPalette.onPrimary : LightColorPalette.onPrimary;
  static Color get primaryContainer => isDarkMode
      ? DarkColorPalette.primaryContainer
      : LightColorPalette.primaryContainer;
  static Color get onPrimaryContainer => isDarkMode
      ? DarkColorPalette.onPrimaryContainer
      : LightColorPalette.onPrimaryContainer;

  static Color get secondary =>
      isDarkMode ? DarkColorPalette.secondary : LightColorPalette.secondary;
  static Color get onSecondary =>
      isDarkMode ? DarkColorPalette.onSecondary : LightColorPalette.onSecondary;
  static Color get secondaryContainer => isDarkMode
      ? DarkColorPalette.secondaryContainer
      : LightColorPalette.secondaryContainer;
  static Color get onSecondaryContainer => isDarkMode
      ? DarkColorPalette.onSecondaryContainer
      : LightColorPalette.onSecondaryContainer;

  static Color get tertiary =>
      isDarkMode ? DarkColorPalette.tertiary : LightColorPalette.tertiary;
  static Color get onTertiary =>
      isDarkMode ? DarkColorPalette.onTertiary : LightColorPalette.onTertiary;
  static Color get tertiaryContainer => isDarkMode
      ? DarkColorPalette.tertiaryContainer
      : LightColorPalette.tertiaryContainer;
  static Color get onTertiaryContainer => isDarkMode
      ? DarkColorPalette.onTertiaryContainer
      : LightColorPalette.onTertiaryContainer;

  static Color get error =>
      isDarkMode ? DarkColorPalette.error : LightColorPalette.error;
  static Color get onError =>
      isDarkMode ? DarkColorPalette.onError : LightColorPalette.onError;
  static Color get errorContainer => isDarkMode
      ? DarkColorPalette.errorContainer
      : LightColorPalette.errorContainer;
  static Color get onErrorContainer => isDarkMode
      ? DarkColorPalette.onErrorContainer
      : LightColorPalette.onErrorContainer;

  static Color get success =>
      isDarkMode ? DarkColorPalette.success : LightColorPalette.success;
  static Color get onSuccess =>
      isDarkMode ? DarkColorPalette.onSuccess : LightColorPalette.onSuccess;
  static Color get successContainer => isDarkMode
      ? DarkColorPalette.successContainer
      : LightColorPalette.successContainer;
  static Color get onSuccessContainer => isDarkMode
      ? DarkColorPalette.onSuccessContainer
      : LightColorPalette.onSuccessContainer;

  static const Color disabled = Color(0xFFD9D9D9);
  static const Color onDisabled = Color(0xFF777777);

  static Color get surfaceChart1 =>
      isDarkMode ? const Color(0xFF69B388) : const Color(0xFF4DA1A9);

  static Color get surfaceChart2 =>
      isDarkMode ? const Color(0xFFF4E285) : const Color(0xFF276FBF);

  static Color get surfaceChart3 =>
      isDarkMode ? const Color(0xFFF4A259) : const Color(0xFFB084CC);

  static Color get surfaceChart4 =>
      isDarkMode ? const Color(0xFFF07F69) : const Color(0xFFD84727);

  static Color get surfaceChart5 =>
      isDarkMode ? const Color(0xFFF7D1CD) : const Color(0xFFFFBA49);
}

abstract class AdditionalColors {
  static const success = Color(0xFF80CD73);
  static const onSuccess = Color(0xFFFFFFFF);
  static const disabled = Color(0xFFD9D9D9);
  static const onDisabled = Color(0xFF777777);

  static Color selected(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF84C6B6) : const Color(0xFF8ED8C7);

  static Color surfaceChart1(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF69B388) : const Color(0xFF4DA1A9);

  static Color surfaceChart2(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFF4E285) : const Color(0xFF276FBF);

  static Color surfaceChart3(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFF4A259) : const Color(0xFFB084CC);

  static Color surfaceChart4(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFF07F69) : const Color(0xFFD84727);

  static Color surfaceChart5(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFF7D1CD) : const Color(0xFFFFBA49);
}

abstract class LightColorPalette {
  static const background = Color(0xFFFFFFFF);
  static const onBackground = Color(0xFF7097C4);

  static const surface = Color(0xFFF8FCFF);
  static const onSurface = Color(0xFF3A6185);
  static const surfaceVariant = Color(0xFFDFE2EB);
  static const onSurfaceVariant = Color(0xFF42474E);

  static const primary = Color(0xFF7097C4);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFFFFFFF);
  static const onPrimaryContainer = Color(0xFF7097C4);

  static const secondary = Color(0xFFE3781F);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFFFFFFF);
  static const onSecondaryContainer = Color(0xFFE3781F);

  static const tertiary = Color(0xFFAB82D9);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFFFFFFF);
  static const onTertiaryContainer = Color(0xFFAB82D9);

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFFFFF);
  static const onErrorContainer = Color(0xFFBA1A1A);

  static const success = Color(0xFF80CD73);
  static const onSuccess = Color(0xFFFFFFFF);
  static const successContainer = Color(0xFFFFFFFF);
  static const onSuccessContainer = Color(0xFF80CD73);

  static const outline = Color(0xFF5095E2);

  static final focusColor = Colors.black.withOpacity(0.12);
  static const brightness = Brightness.light;

  static ColorScheme asColorScheme() {
    return const ColorScheme(
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiary: onTertiary,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      outline: outline,
      brightness: brightness,
    );
  }
}

abstract class DarkColorPalette {
  static const background = Color(0xFF7097C4);
  static const onBackground = Color(0xFFFFFFFF);

  static const surface = Color(0xFF3A6185);
  static const onSurface = Color(0xFFF8FCFF);
  static const surfaceVariant = Color(0xFF42474E);
  static const onSurfaceVariant = Color(0xFFDFE2EB);

  static const primary = Color(0xFFFFFFFF);
  static const onPrimary = Color(0xFF7097C4);
  static const primaryContainer = Color(0xFF7097C4);
  static const onPrimaryContainer = Color(0xFFFFFFFF);

  static const secondary = Color(0xFFFFFFFF);
  static const onSecondary = Color(0xFFE3781F);
  static const secondaryContainer = Color(0xFFE3781F);
  static const onSecondaryContainer = Color(0xFFFFFFFF);

  static const tertiary = Color(0xFFFFFFFF);
  static const onTertiary = Color(0xFFAB82D9);
  static const tertiaryContainer = Color(0xFFAB82D9);
  static const onTertiaryContainer = Color(0xFFFFFFFF);

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFFFFF);
  static const onErrorContainer = Color(0xFFBA1A1A);

  static const success = Color(0xFF80CD73);
  static const onSuccess = Color(0xFFFFFFFF);
  static const successContainer = Color(0xFFFFFFFF);
  static const onSuccessContainer = Color(0xFF80CD73);

  static const outline = Color(0xFF5095E2);

  static final focusColor = Colors.black.withOpacity(0.12);
  static const brightness = Brightness.light;

  static ColorScheme asColorScheme() {
    return const ColorScheme(
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiary: onTertiary,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      outline: outline,
      brightness: brightness,
    );
  }
}