import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'locale.dart';

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

const String studyGroup = "pdaware_beta";
const String studyAvatar = "../images/PDAware-Brandmark-RGB.png";
const studyNickName = "pilot";

// ---------- THEME DATA ----------

abstract class AppThemeData {
  // Sentinel value for the system text scale factor option.
  static const double systemTextScaleFactorOption = -1;

  static ThemeData lightThemeData = themeData(
    LightColorPalette.asColorScheme(),
    LightColorPalette.focusColor,
  );
  static ThemeData darkThemeData = themeData(
    DarkColorPalette.asColorScheme(),
    DarkColorPalette.focusColor,
  );

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      disabledColor: colorScheme.shadow,
      brightness: colorScheme.brightness,
      primaryColor: LightColorPalette.background,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      indicatorColor: colorScheme.onPrimary,
      visualDensity: VisualDensity.standard, colorScheme: colorScheme.copyWith(background: colorScheme.background).copyWith(error: colorScheme.error),
    );
  }
}

class ThemeOptions {
  const ThemeOptions({
    required this.themeMode,
    required double? textScaleFactor,
    required this.customTextDirection,
    required Locale? locale,
    required this.timeDilation,
    required this.platform,
    required this.isTestMode,
  })  : _textScaleFactor = textScaleFactor ?? 1.0,
        _locale = locale;

  final ThemeMode themeMode;
  final double _textScaleFactor;
  final CustomTextDirection customTextDirection;
  final Locale? _locale;
  final double timeDilation;
  final TargetPlatform? platform;
  final bool isTestMode; // True for integration tests.

  // We use a sentinel value to indicate the system text scale option. By
  // default, return the actual text scale factor, otherwise return the
  // sentinel value.
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == AppThemeData.systemTextScaleFactorOption) {
      return useSentinel
          ? AppThemeData.systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  Locale? get locale => _locale ?? deviceLocale;

  /// Returns a text direction based on the [CustomTextDirection] setting.
  /// If it is based on locale and the locale cannot be determined, returns
  /// null.
  TextDirection? resolvedTextDirection() {
    switch (customTextDirection) {
      case CustomTextDirection.localeBased:
        final language = locale?.languageCode.toLowerCase();
        if (language == null) return null;
        return rtlLanguages.contains(language)
            ? TextDirection.rtl
            : TextDirection.ltr;
      case CustomTextDirection.rtl:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  /// Returns a [SystemUiOverlayStyle] based on the [ThemeMode] setting.
  /// In other words, if the theme is dark, returns light; if the theme is
  /// light, returns dark.
  SystemUiOverlayStyle resolvedSystemUiOverlayStyle() {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    final overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return overlayStyle;
  }

  ThemeOptions copyWith({
    ThemeMode? themeMode,
    double? textScaleFactor,
    CustomTextDirection? customTextDirection,
    Locale? locale,
    double? timeDilation,
    TargetPlatform? platform,
    bool? isTestMode,
  }) {
    return ThemeOptions(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      customTextDirection: customTextDirection ?? this.customTextDirection,
      locale: locale ?? this.locale,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      isTestMode: isTestMode ?? this.isTestMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ThemeOptions &&
          themeMode == other.themeMode &&
          _textScaleFactor == other._textScaleFactor &&
          customTextDirection == other.customTextDirection &&
          locale == other.locale &&
          timeDilation == other.timeDilation &&
          platform == other.platform &&
          isTestMode == other.isTestMode;

  @override
  int get hashCode => Object.hash(
    themeMode,
    _textScaleFactor,
    customTextDirection,
    locale,
    timeDilation,
    platform,
    isTestMode,
  );

  static ThemeOptions of(BuildContext context) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, ThemeOptions newModel) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    scope.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingScope extends InheritedWidget {
  const _ModelBindingScope({
    required this.modelBindingState,
    required super.child,
  });

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  const ModelBinding({
    super.key,
    required this.initialModel,
    required this.child,
  });

  final ThemeOptions initialModel;
  final Widget child;

  @override
  State<ModelBinding> createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  late ThemeOptions currentModel;
  Timer? _timeDilationTimer;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void handleTimeDilation(ThemeOptions newModel) {
    if (currentModel.timeDilation != newModel.timeDilation) {
      _timeDilationTimer?.cancel();
      _timeDilationTimer = null;
      if (newModel.timeDilation > 1) {
        // We delay the time dilation change long enough that the user can see
        // that UI has started reacting and then we slam on the brakes so that
        // they see that the time is in fact now dilated.
        _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
          timeDilation = newModel.timeDilation;
        });
      } else {
        timeDilation = newModel.timeDilation;
      }
    }
  }

  void updateModel(ThemeOptions newModel) {
    if (newModel != currentModel) {
      handleTimeDilation(newModel);
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}

bool isDarkMode(BuildContext context) {
  final brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}