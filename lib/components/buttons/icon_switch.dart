import 'package:echowear_components/text.dart';
import 'package:echowear_components/theme.dart';
import 'package:flutter/material.dart';

enum IconSwitchIcon {
  lock,
  unlock,
  gridView,
  listView,
  all_inclusive,
  plan_only
}

IconData __getIcon(IconSwitchIcon icon) {
  switch (icon) {
    case IconSwitchIcon.lock:
      return Icons.lock_outline;
    case IconSwitchIcon.unlock:
      return Icons.lock_open_outlined;
    case IconSwitchIcon.gridView:
      return Icons.grid_view_outlined;
    case IconSwitchIcon.listView:
      return Icons.list_alt_outlined;
    case IconSwitchIcon.all_inclusive:
      return Icons.all_inclusive_outlined;
    case IconSwitchIcon.plan_only:
      return Icons.playlist_add_check_outlined;
  }
}

class IconSwitch extends StatefulWidget {
  const IconSwitch({
    Key? key,
    required this.options,
    required this.onPressed,
    this.selectedIndex = 0,
  }) : super(key: key);

  final List<IconSwitchIcon> options;

  final int selectedIndex;

  final Function(IconSwitchIcon) onPressed;

  @override
  State<IconSwitch> createState() => _IconSwitchState();
}

class _IconSwitchState extends State<IconSwitch> {
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
                child: Icon(
                  __getIcon(widget.options[index]),
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                  size: FontSizes.labelMedium(context),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
