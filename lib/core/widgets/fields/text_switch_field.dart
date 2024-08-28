import 'package:flutter/material.dart';
import 'text_custom_field.dart';

/// Siwtch adaptive button display in suffix
///
/// only can changable status
class TextSwitchField extends StatefulWidget {
  const TextSwitchField({
    super.key,
    this.controller,
    this.value = false,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.onChanged,
    this.input,
  });

  /// Editing controller
  ///
  /// only can listen,
  /// cannot be manupulated outsite
  ///
  /// Only value can be [1] or [0] as [String]
  final TextEditingController? controller;

  /// Switch button value
  /// default [false]
  final bool value;

  /// Label field text
  final String? labelText;

  /// Hint field text
  final String? hintText;

  /// Widget action enabled
  /// default [true]
  final bool enabled;

  /// Input field
  /// depends on [value]
  ///
  /// display input field value
  final String? Function(bool value)? input;

  /// Changed value
  final void Function(bool value)? onChanged;

  @override
  State<TextSwitchField> createState() => _TextSwitchFieldState();
}

class _TextSwitchFieldState extends State<TextSwitchField> {
  /// Switch value
  bool value = false;

  /// Editing field controller
  TextEditingController? controller;

  /// Editing field input controller
  late final TextEditingController fieldController;

  /// Supported [controller] values
  final List<String> supportedValues = <String>["0", "1"];

  @override
  void initState() {
    value = widget.value;
    controller = widget.controller;
    if (supportedValues.contains(controller?.text)) {
      value = controller?.text == "1";
    }
    fieldController = TextEditingController(text: widget.input?.call(value));
    super.initState();
  }

  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextSwitchField oldWidget) {
    if (widget.value != oldWidget.value || widget.controller?.text != widget.controller?.text) {
      value = widget.value;
      if (supportedValues.contains(controller?.text)) {
        value = controller?.text == "1";
      }
      fieldController.text = widget.input?.call(value) ?? "";
      controller?.text = value ? "1" : "0";
    }
    super.didUpdateWidget(oldWidget);
  }

  void onChangedStatus([bool? value]) {
    setState(() => this.value = value ?? !this.value);
    fieldController.text = widget.input?.call(this.value) ?? "";
    controller?.text = this.value ? "1" : "0";
    widget.onChanged?.call(this.value);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: TextCustomField(
        controller: fieldController,
        labelText: widget.labelText,
        hintText: widget.hintText,
        onTap: onChangedStatus,
        readOnly: true,
        suffixIcon: _buildSwitchButton,
      ),
    );
  }

  Widget get _buildSwitchButton {
    return Switch.adaptive(
      value: value,
      onChanged: onChangedStatus,
    );
  }
}
