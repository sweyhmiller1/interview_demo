import 'dart:ui';

/// A class containing all available font weights for the app.
/// Note that in almost all cases, a specific text widget
/// should be used instead of referencing this.
abstract class FontWeights {
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
}