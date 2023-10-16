import 'package:flutter/material.dart';

import '../../../text.dart';
import '../../../theme.dart';

/// Represents the available colors for a `StyledOutlinedButton`
/// widget.
enum StyledOutlinedButtonColor {
  green,
  red,
}

/// Represents the available icons for a `StyledOutlinedButton`
/// widget.
enum StyledOutlinedButtonIcon {
  checkmark,
  x,
  alarm,
  minus,
  plus,
  next,
}

/// Retrieves the appropriate color based on the provided
/// `StyledOutlinedButtonColor` value.
Color __getColorVal(BuildContext context, StyledOutlinedButtonColor color) {
  switch (color) {
    case StyledOutlinedButtonColor.green:
      return AdditionalColors.success;
    case StyledOutlinedButtonColor.red:
      return Theme.of(context).colorScheme.error;
  }
}

/// Retrieves the appropriate icon based on the provided
/// `StyledOutlinedButtonIcon` value.
IconData __getIconVal(StyledOutlinedButtonIcon icon) {
  switch (icon) {
    case StyledOutlinedButtonIcon.checkmark:
      return Icons.check;
    case StyledOutlinedButtonIcon.x:
      return Icons.close;
    case StyledOutlinedButtonIcon.alarm:
      return Icons.alarm;
    case StyledOutlinedButtonIcon.minus:
      return Icons.remove;
    case StyledOutlinedButtonIcon.plus:
      return Icons.add;
    case StyledOutlinedButtonIcon.next:
      return Icons.arrow_right_alt;
  }
}

/// A styled outlined button.
class StyledOutlinedButton extends StatelessWidget {
  const StyledOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = StyledOutlinedButtonColor.green,
    this.enabled = true,
    this.isWide = false,
    this.icon,
  }) : super(key: key);

  /// The text to display on the button.
  final String text;

  /// A callback function to be executed when the button is pressed.
  final Function(TapUpDetails details) onPressed;

  /// A flag indicating whether the button is enabled or
  /// disabled (default is `true`).
  final bool enabled;

  /// The color of the button (default is
  /// `StyledOutlinedButtonColor.green`).
  final StyledOutlinedButtonColor color;

  /// An optional icon to display alongside the text.
  final StyledOutlinedButtonIcon? icon;

  /// Whether or not the button will expand to fill up the maximum
  /// horizontal space.
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: enabled ? false : true,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) {
            onPressed.call(details);
          },
          child: MouseRegion(
            hitTestBehavior: HitTestBehavior.deferToChild,
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: Layout.normalBorderRadius,
                border: Border.all(
                  color: __getColorVal(context, color),
                  width: 3,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Layout.minContainerPadding * 3,
                vertical: Layout.minContainerPadding,
              ),
              constraints: BoxConstraints(
                minWidth: Layout.getConstraintSize(),
                minHeight: Layout.getConstraintSize(),
              ),
              child: Row(
                mainAxisSize: isWide ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: LabelText(
                      text,
                      color: __getColorVal(context, color),
                      selectable: false,
                    ),
                  ),
                  if (icon != null)
                    const SizedBox(width: Layout.minContainerSpacing),
                  if (icon != null)
                    Icon(
                      __getIconVal(icon!),
                      color: __getColorVal(context, color),
                      size: FontSizes.labelMedium(context),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
