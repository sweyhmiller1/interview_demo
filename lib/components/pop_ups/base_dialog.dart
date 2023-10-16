import 'dart:ui';
import 'package:flutter/material.dart';
import '../texts/font_sizes.dart';
import '../theme/layout.dart';

/// An [AlertDialog] that serves as the base for all used Dialogues.
/// This makes styling all of them at once very easy.

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    Key? key,
    this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: Layout.normalBorderRadius,
          side: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
            width: 3,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTapUp: (_) {
                Navigator.of(context).pop();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: FontSizes.headlineMedium(context),
                ),
              ),
            ),
            if (title != null)
              const SizedBox(width: Layout.minContainerSpacing),
            if (title != null) Flexible(child: title!),
            if (title != null)
              const SizedBox(width: Layout.minContainerSpacing),
            Icon(
              Icons.close,
              color: Colors.transparent,
              size: FontSizes.headlineMedium(context),
            ),
          ],
        ),
        content: content,
        actions: actions,
      ),
    );
  }
}
