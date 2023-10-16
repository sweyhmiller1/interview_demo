import 'package:echowear_components/text.dart';
import 'package:echowear_components/theme.dart';
import 'package:flutter/material.dart';

/// The different types of button styles that can be used with
/// the `StyledBasicButton`.
enum StyledBasicButtonType {
  action,
  basic,
  display,
  navigation,
}

/// The different types of button icons that can be used with
/// the `StyledBasicButton`.
enum StyledBasicButtonIcon {
  checkmark,
  save,
  taskIncomplete,
  taskComplete,
  x,
  settings,
  face,
  home,
  plus,
  pencil,
  clipboard,
  clipboardAdd,
  removeUser,
}

/// Calculates and returns the appropriate edge insets
/// (padding) for the given button type.
EdgeInsets __getEdgeInsets(BuildContext context, StyledBasicButtonType type) {
  switch (type) {
    case StyledBasicButtonType.action:
      return const EdgeInsets.symmetric(
        horizontal: Layout.minContainerPadding * 32,
        vertical: Layout.minContainerPadding * 21,
      );

    case StyledBasicButtonType.basic:
    case StyledBasicButtonType.navigation:
      return const EdgeInsets.symmetric(
        horizontal: Layout.minContainerPadding * 3,
        vertical: Layout.minContainerPadding,
      );

    case StyledBasicButtonType.display:
      return EdgeInsets.symmetric(
        horizontal: Layout.minContainerPadding * 3,
        vertical: FontSizes.headlineMedium(context),
      );
  }
}

/// Returns a text widget based on the button type, with the
/// specified color and text style.
Widget __getTextWidget(
  String text,
  StyledBasicButtonType type,
  Color color,
) {
  switch (type) {
    case StyledBasicButtonType.action:
    case StyledBasicButtonType.basic:
      return LabelText(
        text,
        color: color,
        selectable: false,
      );

    case StyledBasicButtonType.display:
    case StyledBasicButtonType.navigation:
      return DisplayText(
        text,
        color: color,
        selectable: false,
      );
  }
}

/// Returns a `double` value representing the appropriate font
/// size for the given button type.
double __getFontSize(
  BuildContext context,
  StyledBasicButtonType type,
) {
  switch (type) {
    case StyledBasicButtonType.action:
    case StyledBasicButtonType.basic:
      return FontSizes.labelMedium(context);

    case StyledBasicButtonType.display:
    case StyledBasicButtonType.navigation:
      return FontSizes.displayMedium(context);
  }
}

/// Returns an Icon widget based on the provided icon type. The
/// icon's color and size are determined by the button type and
/// font size obtained from the `__getFontSize` function.
Widget __getIconWidget(
  BuildContext context,
  StyledBasicButtonType type,
  StyledBasicButtonIcon icon,
  Color color,
) {
  switch (icon) {
    case StyledBasicButtonIcon.checkmark:
      return Icon(
        Icons.check,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.save:
      return Icon(
        Icons.download,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.taskComplete:
      return Icon(
        Icons.check_circle,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.taskIncomplete:
      return Icon(
        Icons.circle_outlined,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.x:
      return Icon(
        Icons.close,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.settings:
      return Icon(
        Icons.settings_outlined,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.face:
      return Icon(
        Icons.face_outlined,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.home:
      return Icon(
        Icons.home_outlined,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.plus:
      return Icon(
        Icons.add,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.pencil:
      return Icon(
        Icons.edit,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.clipboard:
      return Icon(
        Icons.assignment,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.clipboardAdd:
      return Icon(
        Icons.assignment_add,
        color: color,
        size: __getFontSize(context, type),
      );
    case StyledBasicButtonIcon.removeUser:
      return Icon(
        Icons.person_remove,
        color: color,
        size: __getFontSize(context, type),
      );
  }
}

/// [StyledButton] is a base button class. It should not be used in the app
/// itself, but rather as a tool for creating other button widgets.
class StyledBasicButton extends StatefulWidget {
  const StyledBasicButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonType = StyledBasicButtonType.basic,
    this.enabled = true,
    this.toggleable = false,
    this.startSelected = false,
    this.isWide = false,
    this.icon,
  }) : super(key: key);

  /// The text that will appear inside the button.
  final String text;

  /// A function that will be called when the button is pressed, and returns
  /// whether or not the button is selected after being pressed, as well as
  /// a [TapUpDetails] from the button's GestureDetector. If
  /// [StyledBasicButton.toggleable] is false, then it will always return false.
  final Function(bool, TapUpDetails) onPressed;

  /// A [StyledBasicButtonType] that sets the overall look of the button.
  final StyledBasicButtonType buttonType;

  /// An optional icon that will appear to the right of the button's text.
  final StyledBasicButtonIcon? icon;

  /// Whether or not the button is [enabled]. If true, it will have normal
  /// colors, but if false, it will be transparent and have [onPressed]
  /// disabled.
  final bool enabled;

  /// Whether or not the button will be toggleable.
  final bool toggleable;

  /// Whether or not the button will initially appear selected.
  final bool startSelected;

  /// Whether or not the button will expand to fill the maximum possible horizontal
  /// space.
  final bool isWide;

  @override
  State<StyledBasicButton> createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledBasicButton> {
  late bool selected;

  @override
  void initState() {
    super.initState();

    selected = widget.startSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 2,
      ),
      child: IgnorePointer(
        ignoring: !widget.enabled,
        child: Opacity(
          opacity: widget.enabled ? 1 : 0.5,
          child: GestureDetector(
            onTapUp: (details) {
              if (widget.toggleable) {
                setState(() {
                  selected = !selected;
                });
              }
              widget.onPressed.call(selected, details);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              hitTestBehavior: HitTestBehavior.deferToChild,
              child: Container(
                padding: __getEdgeInsets(context, widget.buttonType),
                decoration: BoxDecoration(
                  color: (widget.toggleable && selected) ||
                          (!widget.toggleable && widget.startSelected)
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.primary,
                  borderRadius: Layout.smallBorderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(selected ? 0.5 : 0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  minWidth: Layout.getConstraintSize(),
                  minHeight: Layout.getConstraintSize(),
                ),
                child: Row(
                  mainAxisSize:
                      widget.isWide ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: __getTextWidget(
                        widget.text,
                        widget.buttonType,
                        (widget.toggleable && selected) ||
                                (!widget.toggleable && widget.startSelected)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    if (widget.icon != null)
                      const SizedBox(width: Layout.minContainerSpacing),
                    if (widget.icon != null)
                      __getIconWidget(
                        context,
                        widget.buttonType,
                        widget.icon!,
                        (widget.toggleable && selected) ||
                                (!widget.toggleable && widget.startSelected)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
