import 'package:flutter/material.dart';

import 'font_families.dart';
import 'font_sizes.dart';
import 'font_weights.dart';

/// A list of available variations on the font size for text widgets.
enum FontSizeVariant {
  small,
  medium,
  large,
}

class _ToggleableSelectableText extends StatelessWidget {
  const _ToggleableSelectableText(
      this.text, {
        Key? key,
        required this.selectable,
        required this.textAlign,
        required this.maxLines,
        required this.style,
      }) : super(key: key);

  final String text;

  final bool selectable;
  final TextAlign textAlign;
  final int? maxLines;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    // return AutoHyphenatingText(
    //   text,
    //   textAlign: textAlign,
    //   maxLines: maxLines,
    //   style: style,
    //   selectable: selectable,
    // );

    return selectable
        ? SelectableText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style,
    )
        : Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style,
    );
  }
}

/// Huge text used to for one or two words to take up the entire page.
class HugeText extends StatelessWidget {
  const HugeText(
      this.text, {
        Key? key,
        this.fontSizeVariant = FontSizeVariant.medium,
        this.textAlign,
        this.color,
        this.underlined,
        this.bold,
        this.selectable,
        this.italic,
      }) : super(key: key);

  final String text;

  final FontSizeVariant fontSizeVariant;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underlined;
  final bool? bold;
  final bool? selectable;
  final bool? italic;

  @override
  Widget build(BuildContext context) {
    double fontSize;

    switch (fontSizeVariant) {
      case FontSizeVariant.small:
        fontSize = FontSizes.hugeSmall(context);
        break;
      case FontSizeVariant.medium:
        fontSize = FontSizes.hugeMedium(context);
        break;
      case FontSizeVariant.large:
        fontSize = FontSizes.hugeLarge(context);
        break;
    }

    return _ToggleableSelectableText(
      text,
      selectable: selectable ?? true,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: null,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: (bold ?? false) ? FontWeights.bold : FontWeights.medium,
        fontFamily: FontFamilies.huge,
        fontStyle: (italic ?? false) ? FontStyle.italic : FontStyle.normal,
        decoration: (underlined ?? false)
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 2,
      ),
    );
  }
}

/// Large title-like text used to draw attention.
class DisplayText extends StatelessWidget {
  const DisplayText(
      this.text, {
        Key? key,
        this.fontSizeVariant = FontSizeVariant.medium,
        this.textAlign,
        this.color,
        this.underlined,
        this.bold,
        this.selectable,
        this.italic,
      }) : super(key: key);

  final String text;

  final FontSizeVariant fontSizeVariant;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underlined;
  final bool? bold;
  final bool? selectable;
  final bool? italic;

  @override
  Widget build(BuildContext context) {
    double fontSize;

    switch (fontSizeVariant) {
      case FontSizeVariant.small:
        fontSize = FontSizes.displaySmall(context);
        break;
      case FontSizeVariant.medium:
        fontSize = FontSizes.displayMedium(context);
        break;
      case FontSizeVariant.large:
        fontSize = FontSizes.displayLarge(context);
        break;
    }

    return _ToggleableSelectableText(
      text,
      selectable: selectable ?? true,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: null,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: (bold ?? false) ? FontWeights.bold : FontWeights.medium,
        fontFamily: FontFamilies.display,
        fontStyle: (italic ?? false) ? FontStyle.italic : FontStyle.normal,
        decoration: (underlined ?? false)
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 2,
      ),
    );
  }
}

/// Medium-sized text used primarily for titles in interactive widgets.
class HeadlineText extends StatelessWidget {
  const HeadlineText(
      this.text, {
        Key? key,
        this.fontSizeVariant = FontSizeVariant.medium,
        this.textAlign,
        this.color,
        this.underlined,
        this.bold,
        this.selectable,
        this.italic,
      }) : super(key: key);

  final String text;

  final FontSizeVariant fontSizeVariant;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underlined;
  final bool? bold;
  final bool? selectable;
  final bool? italic;

  @override
  Widget build(BuildContext context) {
    double fontSize;

    switch (fontSizeVariant) {
      case FontSizeVariant.small:
        fontSize = FontSizes.headlineSmall(context);
        break;
      case FontSizeVariant.medium:
        fontSize = FontSizes.headlineMedium(context);
        break;
      case FontSizeVariant.large:
        fontSize = FontSizes.headlineLarge(context);
        break;
    }

    return _ToggleableSelectableText(
      text,
      selectable: selectable ?? true,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: null,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: (bold ?? false) ? FontWeights.bold : FontWeights.medium,
        fontFamily: FontFamilies.headline,
        fontStyle: (italic ?? false) ? FontStyle.italic : FontStyle.normal,
        decoration: (underlined ?? false)
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 2,
      ),
    );
  }
}

/// Smallest text, primarily used for answer buttons.
class LabelText extends StatelessWidget {
  const LabelText(this.text,
      {Key? key,
        this.fontSizeVariant = FontSizeVariant.medium,
        this.textAlign,
        this.color,
        this.underlined,
        this.bold,
        this.selectable,
        this.italic})
      : super(key: key);

  final String text;

  final FontSizeVariant fontSizeVariant;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underlined;
  final bool? bold;
  final bool? selectable;
  final bool? italic;

  @override
  Widget build(BuildContext context) {
    double fontSize;

    switch (fontSizeVariant) {
      case FontSizeVariant.small:
        fontSize = FontSizes.labelSmall(context);
        break;
      case FontSizeVariant.medium:
        fontSize = FontSizes.labelMedium(context);
        break;
      case FontSizeVariant.large:
        fontSize = FontSizes.labelLarge(context);
        break;
    }

    return _ToggleableSelectableText(
      text,
      selectable: selectable ?? true,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: null,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: (bold ?? true) ? FontWeights.bold : FontWeights.medium,
        fontFamily: FontFamilies.label,
        fontStyle: (italic ?? false) ? FontStyle.italic : FontStyle.normal,
        decoration: (underlined ?? false)
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 2,
      ),
    );
  }
}

/// Small text used for bodies of text.
class BodyText extends StatelessWidget {
  const BodyText(
      this.text, {
        Key? key,
        this.fontSizeVariant = FontSizeVariant.medium,
        this.textAlign,
        this.color,
        this.underlined,
        this.bold,
        this.selectable,
        this.italic,
      }) : super(key: key);

  final String text;

  final FontSizeVariant fontSizeVariant;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underlined;
  final bool? bold;
  final bool? selectable;
  final bool? italic;

  @override
  Widget build(BuildContext context) {
    double fontSize;

    switch (fontSizeVariant) {
      case FontSizeVariant.small:
        fontSize = FontSizes.bodySmall(context);
        break;
      case FontSizeVariant.medium:
        fontSize = FontSizes.bodyMedium(context);
        break;
      case FontSizeVariant.large:
        fontSize = FontSizes.bodyLarge(context);
        break;
    }

    return _ToggleableSelectableText(
      text,
      selectable: selectable ?? true,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: null,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: (bold ?? false) ? FontWeights.bold : FontWeights.regular,
        fontFamily: FontFamilies.body,
        fontStyle: (italic ?? false) ? FontStyle.italic : FontStyle.normal,
        decoration: (underlined ?? false)
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 2,
      ),
    );
  }
}