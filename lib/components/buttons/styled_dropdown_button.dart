import 'package:flutter/material.dart';

import '../texts/font_sizes.dart';
import '../texts/text_widgets.dart';
import '../theme/colors.dart';
import '../theme/layout.dart';

/// A styled dropdown button. It does not actually show a
/// dropdown list; in most cases a popup modal should be
/// shown for option selection.
class StyledDropdownButton extends StatelessWidget {
  const StyledDropdownButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.isHintText = false,
    this.label = "Label",
    this.showLabel = true,
  }) : super(key: key);

  /// The text that will appear inside of the button.
  final String text;

  /// A function that will be run when the button is pressed.
  final VoidCallback onPressed;

  /// Whether or not the button is enabled.
  final bool enabled;

  /// Whether or not the text will be transparent, to indicate
  /// that it is hint text.
  final bool isHintText;

  /// A descriptive label of the buttons's intended contents.
  final String label;

  /// Whether or not the label will be shown.
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: IgnorePointer(
        ignoring: !enabled,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (_) {
            onPressed.call();
          },
          child: MouseRegion(
            hitTestBehavior: HitTestBehavior.deferToChild,
            cursor: SystemMouseCursors.click,
            child: Container(
              constraints: BoxConstraints(
                minWidth: Layout.getConstraintSize(),
                minHeight: Layout.getConstraintSize(),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showLabel)
                    Row(
                      children: [
                        Flexible(
                          child: BodyText(
                            label,
                            color: AdditionalColors.disabled,
                            bold: true,
                            selectable: false,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Opacity(
                          opacity: isHintText ? 0.5 : 1,
                          child: LabelText(
                            text,
                            color: Theme.of(context).colorScheme.primary,
                            selectable: false,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.primary,
                        size: FontSizes.labelLarge(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 3,
                    color: Theme.of(context).colorScheme.primary,
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
