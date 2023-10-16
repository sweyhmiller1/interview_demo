import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../services/component_preferences_helper.dart';

/// A class containing functions that give measurements for sizing with the UI theme.
abstract class Layout {
  /// Initializes the sizing class with variables that need to be calculated once the app loads.
  static void init(BuildContext context) {
    debugPrint("Initializing the Layout class...");
    debugPrint("Screen size: ${getScreenSize(context).toString()}");

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
      ],
    );

    _hasBeenInitialized = true;

    debugPrint("Layout class initialization complete");
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool _hasBeenInitialized = false;

  /// Whether or not the [Layout] class has been initialized via [Layout.init]
  /// yet.
  static bool get hasBeenInitialized => _hasBeenInitialized;

  /// [bottomBarFudgeHeight] checks if the platform is android or not to assist in sizing.
  ///
  /// Returns a fudge factor [barHeight] for managing bottom of the screen on
  /// Android vs iOS platforms. TODO:Other platforms should be included.
  static double bottomBarFudgeHeight() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return .15;
      case TargetPlatform.iOS:
        return .10;
      default:
        return .10;
    }
  }

  /// Converts real-world millimeters to a number of pixels. It is roughly accurate but varies slightly between devices.
  static double mmToPx(double mm) {
    // 1mm ≈ 6.299 px
    return mm * 6.299;
  }

  /// The minimum recommended spacing between buttons, in millimeters.
  static const _minButtonSpacingMM = 3.25;

  /// Gets the minimum recommended spacing between buttons.
  static double get minButtonSpacing => mmToPx(_minButtonSpacingMM);

  static const minContainerSpacing = 10.0;

  static const minContainerPadding = 3.0;

  static final normalBorderRadius = BorderRadius.circular(25);
  static final smallBorderRadius = BorderRadius.circular(15);

  static final circularBorderRadius = BorderRadius.circular(1000000);

  static const pagePadding = 15.0;

  static const borderThickness = 8.0;

  static const horizontalTextPadding = 110.0;

  static const pdfLogoWidth = 100.0;

  static const actionRadius = 25.0;
  static const answerRadius = 30.0;

  @internal
  static double getConstraintSize() {
    return ComponentPreferences.getButtonConstraints() ? mmToPx(14) : mmToPx(9);
  }

  static const verticalFormSpacer = SizedBox(height: minContainerSpacing * 3);
  static const horizontalFormSpacer = SizedBox(width: minContainerSpacing * 3);
}