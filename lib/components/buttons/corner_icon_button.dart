import 'package:flutter/material.dart';
import '../texts/font_sizes.dart';
import '../theme/layout.dart';

enum CornerIconButtonSide {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  topCenter,
}

class CornerIconButton extends StatelessWidget {
  const CornerIconButton({
    Key? key,
    required this.icon,
    required this.side,
    required this.onPressed,
    this.seeThrough = false,
    this.tight = false,
  }) : super(key: key);

  final IconData icon;
  final CornerIconButtonSide side;
  final bool seeThrough;
  final VoidCallback onPressed;
  final bool tight;

  @override
  Widget build(BuildContext context) {
    double iconSize = FontSizes.hugeMedium(context) / 2;

    double circleSize = tight
        ? FontSizes.hugeMedium(context) * 1.25
        : FontSizes.hugeMedium(context) * 2.5;

    double largeCirclePadding = Layout.minContainerPadding * 13;
    if (tight) largeCirclePadding /= 4.5;

    double smallCirclePadding = Layout.minContainerPadding * 5;
    if (tight) smallCirclePadding /= 4.5;

    double getXOffset() {
      if (side == CornerIconButtonSide.topCenter) {
        return 0;
      }
      return side == CornerIconButtonSide.topLeft ||
              side == CornerIconButtonSide.bottomLeft
          ? circleSize * 0.5
          : circleSize * -0.5;
    }

    return Stack(
      children: [
        Transform.translate(
          offset: Offset(
            getXOffset(),
            side == CornerIconButtonSide.topLeft ||
                    side == CornerIconButtonSide.topRight ||
                    side == CornerIconButtonSide.topCenter
                ? circleSize * 0.5
                : circleSize * -0.5,
          ),
          child: GestureDetector(
            onTapUp: (_) {
              onPressed.call();
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              hitTestBehavior: HitTestBehavior.deferToChild,
              child: Container(
                width: circleSize,
                height: circleSize,
                padding: EdgeInsets.only(
                  top: (side == CornerIconButtonSide.topLeft ||
                          side == CornerIconButtonSide.topRight ||
                          side == CornerIconButtonSide.topCenter)
                      ? largeCirclePadding
                      : smallCirclePadding,
                  bottom: (side == CornerIconButtonSide.bottomLeft ||
                          side == CornerIconButtonSide.bottomRight)
                      ? largeCirclePadding
                      : smallCirclePadding,
                  left: (side == CornerIconButtonSide.topLeft ||
                              side == CornerIconButtonSide.bottomLeft) &&
                          side != CornerIconButtonSide.topCenter
                      ? largeCirclePadding
                      : smallCirclePadding,
                  right: (side == CornerIconButtonSide.topRight ||
                              side == CornerIconButtonSide.bottomRight) &&
                          side != CornerIconButtonSide.topCenter
                      ? largeCirclePadding
                      : smallCirclePadding,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: (side == CornerIconButtonSide.bottomLeft ||
                            side == CornerIconButtonSide.bottomRight)
                        ? tight
                            ? circleSize * 0.45
                            : circleSize / 2
                        : 0,
                    bottom: (side == CornerIconButtonSide.topLeft ||
                            side == CornerIconButtonSide.topRight ||
                            side == CornerIconButtonSide.topCenter)
                        ? tight
                            ? circleSize * 0.45
                            : circleSize / 2
                        : 0,
                    left: (side == CornerIconButtonSide.topRight ||
                            side == CornerIconButtonSide.bottomRight)
                        ? tight
                            ? circleSize * 0.45
                            : circleSize / 2
                        : 0,
                    right: (side == CornerIconButtonSide.topLeft ||
                            side == CornerIconButtonSide.bottomLeft)
                        ? tight
                            ? circleSize * 0.45
                            : circleSize / 2
                        : 0,
                  ),
                  child: IgnorePointer(
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: iconSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
