import 'dart:math';

import 'package:flutter/material.dart';

import '../texts/font_families.dart';
import '../texts/font_sizes.dart';
import '../texts/text_widgets.dart';
import '../theme/colors.dart';
import '../theme/layout.dart';

class StyledSlider extends StatefulWidget {
  const StyledSlider({
    Key? key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftValue,
    required this.rightValue,
    required this.onChanged,
    this.leftIcon,
    this.rightIcon,
    this.initialValue,
  }) : super(key: key);

  final String leftLabel;
  final String rightLabel;

  final int leftValue;
  final int rightValue;

  final int? initialValue;

  final String? leftIcon;
  final String? rightIcon;

  final Function(int val) onChanged;

  @override
  State<StyledSlider> createState() => _StyledSliderState();
}

class _StyledSliderState extends State<StyledSlider> {
  double? currentValue;

  @override
  Widget build(BuildContext context) {
    currentValue ??= widget.initialValue != null
        ? widget.initialValue!.toDouble()
        : widget.leftValue.toDouble();

    double sliderHeight = max(
      Layout.getConstraintSize(),
      FontSizes.labelMedium(context) * 0.85,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.leftIcon != null)
              Container(
                height: sliderHeight,
                alignment: Alignment.center,
                child: Text(
                  widget.leftIcon!,
                  style: TextStyle(
                    fontSize: FontSizes.displayLarge(context),
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontFamily: FontFamilies.display,
                  ),
                ),
              ),
            if (widget.leftIcon != null)
              const SizedBox(width: Layout.minContainerSpacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    widget.leftIcon != null && widget.rightIcon != null
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SizedBox(
                      height: sliderHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: sliderHeight / 8,
                            ),
                            height: sliderHeight * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: Layout.circularBorderRadius,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 1),
                                  blurRadius: 4,
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AdditionalColors.disabled,
                                  Theme.of(context).colorScheme.primary,
                                ],
                              ),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                                thumbColor:
                                    Theme.of(context).colorScheme.background,
                                thumbShape: _CircleThumbShape(
                                  thumbRadius: sliderHeight / 2,
                                  insideColor: Color.lerp(
                                    AdditionalColors.disabled,
                                    Theme.of(context).colorScheme.primary,
                                    currentValue! / widget.rightValue,
                                  )!,
                                  borderSize: sliderHeight / 5,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 1),
                              ),
                              child: Slider(
                                min: widget.leftValue.toDouble(),
                                max: widget.rightValue.toDouble(),
                                value: widget.initialValue == null
                                    ? widget.leftValue.toDouble()
                                    : widget.initialValue!.toDouble(),
                                onChanged: (newVal) {
                                  setState(() {
                                    currentValue = newVal;
                                    widget.onChanged.call(newVal.round());
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelText(
                        widget.leftLabel,
                        color: AdditionalColors.disabled,
                      ),
                      LabelText(
                        widget.rightLabel,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.rightIcon != null)
              const SizedBox(width: Layout.minContainerSpacing),
            if (widget.rightIcon != null)
              Container(
                height: sliderHeight,
                alignment: Alignment.center,
                child: Text(
                  widget.rightIcon!,
                  style: TextStyle(
                    fontSize: FontSizes.displayLarge(context),
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontFamily: FontFamilies.display,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  final Color insideColor;

  final double borderSize;

  const _CircleThumbShape({
    required this.thumbRadius,
    required this.borderSize,
    required this.insideColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final Canvas canvas = context.canvas;

    final innerPaint = Paint()
      ..color = insideColor
      ..style = PaintingStyle.fill;

    final outerPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    var outsidePath = Path();
    outsidePath.addOval(Rect.fromCircle(center: center, radius: thumbRadius));

    canvas.drawShadow(outsidePath, Colors.black, 3, true);
    canvas.drawPath(outsidePath, outerPaint);

    var insidePath = Path();
    insidePath.addOval(
        Rect.fromCircle(center: center, radius: thumbRadius - borderSize));

    canvas.drawShadow(insidePath, Colors.black, 3, true);
    canvas.drawPath(insidePath, innerPaint);
  }
}
