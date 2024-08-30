import 'package:flutter/material.dart';

class CheckboxGroup extends StatelessWidget {
  const CheckboxGroup({
    super.key,
    required this.itemCount,
    required this.selected,
    this.onChanged,
    required this.itemBuilder,
  });

  final int itemCount;
  final bool Function(int index) selected;
  final void Function(int index, bool? value)? onChanged;
  final String Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 1.0),
      itemBuilder: (context, index) {
        return CheckboxListTile(
          visualDensity: VisualDensity.compact,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          value: selected.call(index),
          title: Text(itemBuilder.call(index)),
          onChanged: (value) {
            onChanged?.call(index, value);
          },
        );
      },
    );
  }
}
