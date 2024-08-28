import '/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DropDownField<T> extends StatelessWidget {
  const DropDownField({
    super.key,
    this.labelText,
    this.hintText,
    this.mandantory = false,
    this.floatingLabelBehavior,
    required this.items,
    required this.value,
    required this.itemBuilder,
    this.onChanged,
  });

  /// Label text
  final String? labelText;

  /// Hint text
  final String? hintText;

  /// Is required
  final bool mandantory;

  /// Label behavior
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// List items
  final List<T> items;

  /// Selected value
  final T? value;

  /// Item builder
  final String? Function(T? value) itemBuilder;

  /// When Changed
  final void Function(T? item)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: false,
          child: TextCustomField(
            labelText: labelText,
            hintText: hintText,
            mandantory: mandantory,
            floatingLabelBehavior: floatingLabelBehavior,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            controller: TextEditingController(text: itemBuilder.call(value)),
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: DropdownButton<T>(
            isDense: true,
            value: value,
            isExpanded: true,
            elevation: 16,
            dropdownColor: Colors.white,
            underline: const SizedBox.shrink(),
            borderRadius: BorderRadius.circular(8.0),
            onChanged: onChanged,
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(itemBuilder.call(value) ?? "-"),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
