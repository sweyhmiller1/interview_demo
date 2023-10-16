import 'package:flutter/material.dart';

import '../texts/font_sizes.dart';
import '../texts/text_widgets.dart';
import '../theme/layout.dart';


/// This enum represents different icons that can be used with
/// the `CircularIconButton`.
enum CircularIconButtonIcon {
  mic,
  plus,
  book,
  keyboard,
  backspace,
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  clearMemory,
  info,
  code,
  copy,
  home,
}

/// Returns a colored icon widget based on an [IconData].
Widget __iconWidget(BuildContext context, IconData icon, bool selected) {
  return Icon(
    icon,
    color: selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary,
    size: FontSizes.headlineMedium(context),
  );
}

/// Returns a colored text widget based on a string.
Widget __textWidget(BuildContext context, String text, bool selected) {
  return HeadlineText(
    text,
    selectable: false,
    color: selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary,
    textAlign: TextAlign.center,
  );
}

/// Uses [__iconWidget] and [__textWidget] to return a child
/// that will be shown inside the [CircularIconButton].
Widget __getChild(
    BuildContext context, CircularIconButtonIcon icon, bool selected) {
  switch (icon) {
    case CircularIconButtonIcon.mic:
      return __iconWidget(context, Icons.mic, selected);
    case CircularIconButtonIcon.plus:
      return __iconWidget(context, Icons.add, selected);
    case CircularIconButtonIcon.book:
      return __iconWidget(context, Icons.menu_book, selected);
    case CircularIconButtonIcon.keyboard:
      return __iconWidget(context, Icons.keyboard, selected);
    case CircularIconButtonIcon.backspace:
      return Padding(
        padding: EdgeInsets.all(FontSizes.headlineMedium(context) / 5),
        child: __iconWidget(context, Icons.backspace, selected),
      );
    case CircularIconButtonIcon.code:
      return __iconWidget(context, Icons.code, selected);
    case CircularIconButtonIcon.copy:
      return __iconWidget(context, Icons.copy, selected);
    case CircularIconButtonIcon.home:
      return __iconWidget(context, Icons.home_outlined, selected);
    case CircularIconButtonIcon.zero:
      return __textWidget(context, "0", selected);
    case CircularIconButtonIcon.one:
      return __textWidget(context, "1", selected);
    case CircularIconButtonIcon.two:
      return __textWidget(context, "2", selected);
    case CircularIconButtonIcon.three:
      return __textWidget(context, "3", selected);
    case CircularIconButtonIcon.four:
      return __textWidget(context, "4", selected);
    case CircularIconButtonIcon.five:
      return __textWidget(context, "5", selected);
    case CircularIconButtonIcon.six:
      return __textWidget(context, "6", selected);
    case CircularIconButtonIcon.seven:
      return __textWidget(context, "7", selected);
    case CircularIconButtonIcon.eight:
      return __textWidget(context, "8", selected);
    case CircularIconButtonIcon.nine:
      return __textWidget(context, "9", selected);
    case CircularIconButtonIcon.clearMemory:
      return __textWidget(context, "CE", selected);
    case CircularIconButtonIcon.info:
      return __textWidget(context, "i", selected);
  }
}

/// A circular icon button.
class CircularIconButton extends StatefulWidget {
  const CircularIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.toggleable = false,
    this.startSelected = false,
  }) : super(key: key);

  /// The icon that will appear inside of the button.
  final CircularIconButtonIcon icon;

  /// A function that will be called when the button is pressed, and returns
  /// whether or not the button is selected after being pressed, as well as
  /// a [TapUpDetails] from the button's GestureDetector. If
  /// [CircularIconButton.toggleable] is false, then it will always return false.
  final Function(bool, TapUpDetails) onPressed;

  /// Whether or not the button will be toggleable.
  final bool toggleable;

  /// Whether or not the button will initially appear selected.
  final bool startSelected;

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton> {
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
          hitTestBehavior: HitTestBehavior.deferToChild,
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: const EdgeInsets.all(9),
            constraints: BoxConstraints(
              minWidth: Layout.getConstraintSize(),
              minHeight: Layout.getConstraintSize(),
            ),
            decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: __getChild(context, widget.icon, selected),
            ),
          ),
        ),
      ),
    );
  }
}
