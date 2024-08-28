import 'package:flutter/material.dart';
import '/core/models/models.dart';

class FormDynamicFieldSelectableList extends StatelessWidget {
  const FormDynamicFieldSelectableList({
    super.key,
    required this.selecteds,
    required this.type,
    required this.options,
    required this.onChanged,
  });

  /// Field selected options
  final List<FormDynamicFieldOption> selecteds;

  /// Field type
  /// only [FormDynamicFieldType.checkbox] or [FormDynamicFieldType.select]
  final FormDynamicFieldType type;

  /// Field options
  final List<FormDynamicFieldOption> options;

  /// When changed selecteds
  ///
  final void Function(String? value) onChanged;

  /// Tap item
  ///
  void Function() _onTap(FormDynamicFieldOption option, bool selected) {
    return () {
      List<FormDynamicFieldOption> copyiedSelecteds = List.from(selecteds);
      if (selected) copyiedSelecteds.remove(option);
      if (!selected) copyiedSelecteds.add(option);
      final values = copyiedSelecteds.map((e) => e.id.toString()).toList();
      onChanged.call(values.join(','));
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (_, index) => const SizedBox(height: 1.0),
      itemBuilder: (_, index) {
        final option = options[index];
        bool selected = selecteds.contains(option);
        return ListTile(
          selected: selected,
          visualDensity: VisualDensity.compact,
          leading: _buildLeading(selected),
          title: Text(option.value),
          onTap: _onTap(option, selected),
        );
      },
    );
  }

  Widget? _buildLeading(bool selected) {
    if (type == FormDynamicFieldType.select) return null;
    return Checkbox(value: selected, onChanged: null);
  }
}
