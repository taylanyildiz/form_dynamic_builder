import 'package:flutter/material.dart';

class FormDynamicFieldHeader extends StatelessWidget {
  const FormDynamicFieldHeader({
    super.key,
    required this.fieldId,
    required this.label,
  });

  /// Specified field id
  final String fieldId;

  /// Field label text
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Text(label ?? "-", style: textTheme.labelLarge);
  }
}
