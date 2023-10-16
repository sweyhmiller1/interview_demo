import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// A class containing all available font sizes for the app.
/// Note that in almost all cases, a specific text widget
/// should be used instead of referencing this.
///
/// Text scaling works by dividing the screen's width or
/// height (whichever is larger) by 1000, then multiplying
/// that resulting value by whatever font size is requested.
/// The multiplier will never go below 1 for the sake of
/// readability.
abstract class FontSizes {
  static double __fontSizeMultiplier(BuildContext context) {
    return ResponsiveValue<double>(
      context,
      defaultValue: 1.0,
      conditionalValues: [
        Condition.equals(name: DESKTOP, value: 1.1),
        Condition.equals(name: 'XL', value: 1.2),
      ],
    ).value!;
  }

  static double labelSmall(BuildContext context) =>
      16.0 * __fontSizeMultiplier(context);
  static double labelMedium(BuildContext context) =>
      18.0 * __fontSizeMultiplier(context);
  static double labelLarge(BuildContext context) =>
      20.0 * __fontSizeMultiplier(context);

  static double bodySmall(BuildContext context) =>
      14.0 * __fontSizeMultiplier(context);
  static double bodyMedium(BuildContext context) =>
      16.0 * __fontSizeMultiplier(context);
  static double bodyLarge(BuildContext context) =>
      20.0 * __fontSizeMultiplier(context);

  static double headlineSmall(BuildContext context) =>
      20.0 * __fontSizeMultiplier(context);
  static double headlineMedium(BuildContext context) =>
      24.0 * __fontSizeMultiplier(context);
  static double headlineLarge(BuildContext context) =>
      28.0 * __fontSizeMultiplier(context);

  static double displaySmall(BuildContext context) =>
      24.0 * __fontSizeMultiplier(context);
  static double displayMedium(BuildContext context) =>
      28.0 * __fontSizeMultiplier(context);
  static double displayLarge(BuildContext context) =>
      34.0 * __fontSizeMultiplier(context);

  static double hugeSmall(BuildContext context) =>
      68.0 * __fontSizeMultiplier(context);
  static double hugeMedium(BuildContext context) =>
      72.0 * __fontSizeMultiplier(context);
  static double hugeLarge(BuildContext context) =>
      76.0 * __fontSizeMultiplier(context);
}