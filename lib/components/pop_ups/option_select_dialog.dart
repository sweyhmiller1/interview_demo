import 'package:echowear_components/buttons.dart';
import 'package:echowear_components/text.dart';
import 'package:flutter/material.dart';

import '../theme/layout.dart';
import 'base_dialog.dart';

class OptionSelectDialog extends StatelessWidget {
  const OptionSelectDialog({
    Key? key,
    required this.title,
    required this.options,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final List<String> options;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: HeadlineText(
        title,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
                const SizedBox(height: Layout.minContainerSpacing),
              ] +
              List<Widget>.generate(
                options.length,
                (index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index != 0) SizedBox(height: Layout.minButtonSpacing),
                    StyledBasicButton(
                      text: options[index],
                      isWide: true,
                      onPressed: (_, __) {
                        onPressed.call(index);
                      },
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
