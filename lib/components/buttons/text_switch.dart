import 'package:echowear_components/text.dart';
import 'package:echowear_components/theme.dart';
import 'package:flutter/material.dart';

class TextSwitch extends StatefulWidget {
  const TextSwitch({
    Key? key,
    required this.options,
    required this.onPressed,
    this.selectedIndex = 0,
  }) : super(key: key);

  final List<String> options;

  final int selectedIndex;

  final Function(String) onPressed;

  @override
  State<TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends State<TextSwitch> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: Layout.normalBorderRadius,
      ),
      padding: const EdgeInsets.all(Layout.minContainerPadding * 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(widget.options.length, (index) {
          return GestureDetector(
            onTapUp: (_) {
              setState(() {
                selectedIndex = index;
              });
              widget.onPressed.call(widget.options[index]);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: Layout.getConstraintSize(),
                  minHeight: Layout.getConstraintSize(),
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.transparent,
                  borderRadius: Layout.circularBorderRadius,
                ),
                padding: const EdgeInsets.all(Layout.minContainerPadding * 2),
                child: LabelText(
                  widget.options[index],
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                  selectable: false,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
