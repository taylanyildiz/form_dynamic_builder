import '/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'text_custom_field.dart';

/// A Customized [TextFormField] for searching
///
/// Clear button display if [controller] not null to clear input field
///

class TextSearchField extends StatefulWidget {
  const TextSearchField({
    super.key,
    this.hintText,
    this.initialValue,
    this.focusNode,
    this.onEditingComplete,
    this.onChange,
  });

  final String? hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final void Function(String? input)? onChange;

  @override
  State<TextSearchField> createState() => _TextSearchFieldState();
}

class _TextSearchFieldState extends State<TextSearchField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextCustomField(
      prefixIcon: prefixIcon,
      controller: controller,
      hintText: widget.hintText,
      focusNode: widget.focusNode,
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      constraints: const BoxConstraints(maxHeight: 42.0),
      onEditingComplete: widget.onEditingComplete,
      onChange: widget.onChange,
      fillColor: ColorConstants.gray100,
      border: border,
      focusedBorder: border,
      enabledBorder: border,
      inputAction: TextInputAction.search,
      suffixBuilder: (input) {
        if (input?.isEmpty ?? true) return null;
        return IconButton(
          onPressed: () {
            controller.clear();
            widget.onChange?.call(null);
          },
          icon: const Icon(Icons.close),
        );
      },
    );
  }

  Widget get prefixIcon => const Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
        child: Icon(Icons.search),
      );

  InputBorder? get border => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      );
}
