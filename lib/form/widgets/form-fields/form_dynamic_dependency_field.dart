import 'package:flutter/material.dart';
import '/core/constants/constants.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';

class FormDynamicDependencyField extends StatelessWidget {
  const FormDynamicDependencyField({
    super.key,
    required this.dependencyContent,
    required this.fieldType,
    required this.onChanged,
    List<FormDynamicFieldOption>? fieldOptions,
  }) : fieldOptions = fieldOptions ?? const <FormDynamicFieldOption>[];

  /// Dependency type
  ///
  final FormFieldDependencyContent dependencyContent;

  /// Dependency type
  FormDynamicDependencyType get dependencyType => dependencyContent.depend;

  /// Depend type is contains
  bool get isContain => dependencyType == FormDynamicDependencyType.contain;

  /// Form dynamic field type
  ///
  final FormDynamicFieldType fieldType;

  /// Field options
  ///
  /// if [fieldType] is [FormDynamicFieldType.select] and [multiSelectable] is true
  ///
  /// default [empty]
  final List<FormDynamicFieldOption> fieldOptions;

  /// When changed value
  ///
  final void Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    final contentValue = dependencyContent.value;
    List<FormDynamicFieldOption> selecteds = fieldOptions.where((e) => (contentValue.split(',')).any((e1) => e1 == e.id)).toList().cast<FormDynamicFieldOption>().toList();
    FormDynamicFieldOption? selected = selecteds.firstOrNull;
    Widget field = switch (fieldType) {
      FormDynamicFieldType.text => TextCustomField(
          hintText: "Value",
          initialValue: contentValue,
          onChange: onChanged,
        ),
      FormDynamicFieldType.select => DropdownField<FormDynamicFieldOption>(
          items: fieldOptions,
          multiSelectable: isContain,
          value: isContain ? selecteds : selected,
          onChanged: (items) {
            onChanged.call(items.map((e) => e.id).join(','));
          },
          selectedBuilder: (context, selected) {
            return Card(
              color: ColorConstants.gray100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  selected.value,
                  style: const TextStyle(fontSize: 10.0),
                ),
              ),
            );
          },
          itemBuilder: (context, item, selected) {
            return ListTile(
              selected: selected,
              title: Text(item.value),
            );
          },
        ),
      FormDynamicFieldType.dateTime => TextDateTimeField(
          hintText: "Value",
          initialDate: contentValue,
          onChanged: onChanged,
        ),
      _ => const SizedBox.shrink(),
    };
    return KeyedSubtree(
      key: ValueKey("Content-Value-${dependencyContent.id}"),
      child: field,
    );
  }
}
