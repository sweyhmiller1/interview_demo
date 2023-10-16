import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../texts/font_families.dart';
import '../texts/font_sizes.dart';
import '../texts/font_weights.dart';
import '../texts/text_widgets.dart';
import '../theme/colors.dart';
import '../theme/layout.dart';

/// An enum that contains the possible behaviors for text fields.
/// It has the following values:
/// * normal - Allows all characters to be typed.
/// * integer - Allows only numbers to be typed.
/// * decimal - Allows only numbers and a single decimal point
/// to be typed.
enum StyledTextFieldType {
  normal,
  integer,
  decimal,
}

/// A custom styled text field widget.
class StyledTextField extends StatefulWidget {
  const StyledTextField({
    Key? key,
    required this.maxLines,
    required this.onTextChanged,
    this.minLines = 1,
    this.grow = false,
    this.type = StyledTextFieldType.normal,
    this.label = "Label",
    this.showLabel = true,
    this.enabled = true,
    this.hintText,
    this.initialText,
    this.onFocusChanged,
    this.maxChars,
    this.controller,
  }) : super(key: key);

  /// The maximum number of lines the text field can have.
  final int maxLines;

  /// The minimum number of lines the text field can have. It defaults
  /// to 1.
  final int minLines;

  /// A boolean flag indicating whether the text field should grow to
  /// accommodate multiple lines of text. If true, the text field will
  /// start at [minLines] and be capped at [maxLines]. Otherwise, it
  /// will behave normally.
  final bool grow;

  /// The hint text to display when the text field is empty. If set to
  /// `null`, it will be empty.
  final String? hintText;

  /// The initial text to display in the text field. If set to `null`,
  /// it will be empty.
  final String? initialText;

  /// The type of the text field, represented by `StyledTextFieldType`.
  /// It defaults to `StyledTextFieldType.normal`.
  final StyledTextFieldType type;

  /// A function that will be called when the text in the text field
  /// changes. It takes a `String` parameter representing the new text
  /// value.
  final Function(String) onTextChanged;

  /// An optional function that will be called when the focus state of
  /// the text field changes. It takes a boolean parameter indicating
  /// whether the field is currently focused.
  final Function(bool)? onFocusChanged;

  /// An optional max number of characters that will be allowed in the
  /// text field.
  final int? maxChars;

  /// A descriptive label of the text field's intended contents.
  final String label;

  /// Whether or not the label will be shown.
  final bool showLabel;

  /// Whether or not the text field is enabled.
  final bool enabled;

  /// An optional [TextEditingController] for the text field to use.
  final TextEditingController? controller;

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  TextEditingController backupController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialText != null) {
      if (widget.controller == null) {
        backupController.text = widget.initialText!;
      } else {
        widget.controller!.text = widget.initialText!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1 : 0.5,
      child: IgnorePointer(
        ignoring: !widget.enabled,
        child: Container(
          constraints: BoxConstraints(
            minWidth: Layout.getConstraintSize(),
            minHeight: Layout.getConstraintSize(),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showLabel)
                BodyText(
                  widget.label,
                  color: AdditionalColors.disabled,
                  bold: true,
                  selectable: false,
                ),
              Center(
                child: Material(
                  type: MaterialType.transparency,
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focused) {
                        if (widget.onFocusChanged != null) {
                          widget.onFocusChanged!.call(focused);
                        }
                      },
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: widget.controller ?? backupController,
                        onChanged: (text) {
                          widget.onTextChanged.call(text);
                        },
                        keyboardType: widget.type == StyledTextFieldType.normal
                            ? TextInputType.multiline
                            : TextInputType.numberWithOptions(
                                signed: true,
                                decimal:
                                    widget.type == StyledTextFieldType.decimal
                                        ? true
                                        : false,
                              ),
                        inputFormatters: <TextInputFormatter>[
                          if (widget.type == StyledTextFieldType.integer)
                            FilteringTextInputFormatter.digitsOnly,
                          if (widget.type == StyledTextFieldType.decimal)
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          if (widget.maxChars != null)
                            LengthLimitingTextInputFormatter(widget.maxChars),
                        ],
                        cursorColor: Theme.of(context).colorScheme.primary,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            fontSize: FontSizes.labelMedium(context),
                            fontWeight: FontWeights.bold,
                            fontFamily: FontFamilies.label,
                          ),
                          hintText: widget.hintText,
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: FontSizes.labelMedium(context),
                          fontWeight: FontWeights.bold,
                          fontFamily: FontFamilies.label,
                        ),
                        minLines:
                            widget.grow ? widget.minLines : widget.maxLines,
                        maxLines: widget.maxLines,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
