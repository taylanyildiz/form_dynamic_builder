import 'package:flutter/material.dart';

class CheckboxCustom extends StatelessWidget {
  const CheckboxCustom({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  /// Checkbox title
  final String title;

  /// Checkbox value
  final bool value;

  /// When changed value
  /// default returns [false]
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          value: value,
          onChanged: (value) {
            onChanged.call(value ?? false);
          },
        ),
        Expanded(child: Text(title))
      ],
    );
  }
}
