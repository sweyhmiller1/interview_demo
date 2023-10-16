import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../texts/font_families.dart';
import '../texts/font_sizes.dart';
import '../texts/font_weights.dart';
import '../theme/colors.dart';

class LineGraph extends StatelessWidget {
  final BuildContext context;
  final List<double> data;
  final String? title;
  final String? xLabel;
  final String? yLabel;

  const LineGraph(
      {super.key,
      required this.context,
      required this.data,
      this.title,
      this.xLabel,
      this.yLabel});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineGraphPainter(
          context: context,
          data: data,
          title: title,
          xLabel: xLabel,
          yLabel: yLabel),
      size: Size.infinite,
    );
  }
}

class LineGraphPainter extends CustomPainter {
  final BuildContext context;
  final List<double> data;
  final String? title;
  final String? xLabel;
  final String? yLabel;

  LineGraphPainter(
      {required this.context,
      required this.data,
      this.title,
      this.xLabel,
      this.yLabel});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Theme.of(context).colorScheme.onBackground
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // Calculate the maximum value in the data array to determine the range of values
    final maxValue = data.reduce((curr, next) => curr > next ? curr : next);
    const numYGridlines = 5;
    final yGridLineStep = (maxValue / numYGridlines);

    // Setting what decimal we round to on the y axis
    late int roundToDecimal;
    if (yGridLineStep < 1) {
      roundToDecimal = 1;
    } else {
      roundToDecimal = 0;
    }

    double maxLabelVal = 0;
    for (int i = 0; i <= numYGridlines; i++) {
      maxLabelVal = max(maxLabelVal, i * yGridLineStep);
    }
    final renderParagraph = RenderParagraph(
      TextSpan(
        text: maxLabelVal.toStringAsFixed(roundToDecimal),
        style: TextStyle(
          fontWeight: FontWeights.regular,
          fontSize: FontSizes.bodyMedium(context),
          fontFamily: FontFamilies.body,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );
    double textLen = renderParagraph
        .getMinIntrinsicWidth(FontSizes.bodyMedium(context))
        .ceilToDouble();

    final path = Path();
    final stepX = (size.width - textLen * 2 - 10) / (data.length - 1);

    final stepY = size.height / maxValue;

    path.moveTo(textLen + 5, size.height - data[0] * stepY);

    for (int i = 1; i < data.length; i++) {
      final x = i * stepX + textLen + 5;
      final y = size.height - data[i] * stepY;
      final xPrev = (i - 1) * stepX + textLen + 5;
      final yPrev = size.height - data[i - 1] * stepY;
      path.cubicTo(xPrev + stepX / 2, yPrev, x - stepX / 2, y, x, y);
    }

    //final textStyle = TextStyle(color: Colors.grey[700], fontSize: 10.0);

    final axisPaint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const yAxisLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    );

    final textStyle = yAxisLabelStyle.copyWith(fontSize: 10.0);

    // Draw the horizontal gridlines and their corresponding labels
    for (int i = 0; i <= numYGridlines; i++) {
      final value = i * yGridLineStep;
      final y = size.height - value * stepY;
      canvas.drawLine(Offset(textLen + 5, y),
          Offset(size.width - textLen - 5, y), axisPaint);

      final paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.right,
          fontWeight: FontWeight.bold,
          fontSize: yAxisLabelStyle.fontSize,
          textDirection: TextDirection.rtl,
        ),
      );

      paragraphBuilder.pushStyle(
        ui.TextStyle(
          color: ThemeColors.onBackground,
          fontSize: FontSizes.bodyMedium(context),
          fontWeight: FontWeights.regular,
          fontFamily: FontFamilies.body,
        ),
      );
      paragraphBuilder.addText(value.toStringAsFixed(roundToDecimal));
      final paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: textLen));
      canvas.drawParagraph(paragraph, Offset(0, y - paragraph.height / 2));

      canvas.drawPath(path, linePaint);
    }

    // Draw the vertical gridlines and their corresponding labels
    const numXGridlines = 0; //data.length - 1;
    for (int i = 0; i <= numXGridlines; i++) {
      final x = i * stepX + textLen + 5;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), axisPaint);
      final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.center,
          fontSize: textStyle.fontSize,
          textDirection: TextDirection.ltr));
      // paragraphBuilder.addText((i + 1).toString());
      final paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: stepX));
      canvas.drawParagraph(paragraph, Offset(x - stepX / 2, size.height + 5));
    }

    // Draw the x axis label
    if (xLabel != null) {
      final textSpan = TextSpan(
        text: xLabel!,
        style: yAxisLabelStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      textPainter.paint(
          canvas,
          Offset(size.width / 2 - textPainter.width / 2,
              size.height + textPainter.height));
    }

    // Draw the y axis label
    if (yLabel != null) {
      final textSpan = TextSpan(
        text: yLabel!,
        style: yAxisLabelStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, size.height / 2));
    }

    // Draw the title
    if (title != null) {
      final titleStyle = TextStyle(
        color: Colors.grey[700],
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      );
      final textSpan = TextSpan(
        text: title!,
        style: titleStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();
      textPainter.paint(
          canvas, Offset(size.width / 2 - textPainter.width / 2, -20));
    }
  }

  @override
  bool shouldRepaint(LineGraphPainter oldDelegate) {
    return !listEquals(data, oldDelegate.data) ||
        xLabel != oldDelegate.xLabel ||
        yLabel != oldDelegate.yLabel ||
        title != oldDelegate.title;
  }
}
