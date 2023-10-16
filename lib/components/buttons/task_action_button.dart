import 'package:flutter/material.dart';
import 'package:interview_demo/components/buttons/styled_basic_button.dart';

/// [TaskActionButton] is a check button that runs a function.
/// It takes in a boolean that controls whether the checkbox
/// is empty or not. The intended use is for an outside
/// variable to control whether or not the button is checked,
/// and for the [TaskActionButton.startOfTask] function to
/// update that variable.
class TaskActionButton extends StatelessWidget {
  const TaskActionButton({
    Key? key,
    required this.text,
    required this.taskComplete,
    required this.startOfTask,
    this.canContinue = true,
    this.isWide = false,
  }) : super(key: key);

  /// The text that will appear on the button.
  final String text;

  /// Whether or not the task has been completed yet.
  final bool taskComplete;

  /// The function that will be run when the button is pressed.
  final Function(TapUpDetails) startOfTask;

  /// Whether or not the button is enabled.
  final bool canContinue;

  /// Whether or not the button will expand to fill the maximum possible horizontal
  /// space.
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return StyledBasicButton(
      text: text,
      onPressed: (_, details) {
        startOfTask.call(details);
      },
      enabled: canContinue,
      isWide: isWide,
      icon: taskComplete
          ? StyledBasicButtonIcon.taskComplete
          : StyledBasicButtonIcon.taskIncomplete,
    );
  }
}
