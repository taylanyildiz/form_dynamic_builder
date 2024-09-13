import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/providers.dart';
import '/core/constants/constants.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';

class FormDynamicDependencyField extends ConsumerWidget {
  const FormDynamicDependencyField({
    super.key,
    required this.fieldId,
    required this.dependId,
    required this.content,
    List<FormDynamicFieldOption>? fieldOptions,
  });

  /// Dependency field id
  final String fieldId;

  /// Dependency id
  ///
  final String dependId;

  /// Dependency content
  ///
  final FormFieldDependencyContent content;

  /// Dependency type
  ///
  FormDynamicDependencyType get dependencyType => content.depend;

  /// Depend type is contains
  bool get isContain => dependencyType == FormDynamicDependencyType.contain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dynamicField = ref.read(formFieldProvider(fieldId));
    final fieldOptions = dynamicField.options;
    final fieldType = dynamicField.type;

    final fieldDependencyNotifier = ref.read(formFieldDependencyProvider(fieldId).notifier);

    final contentValue = content.value;
    List<FormDynamicFieldOption> selecteds = fieldOptions.where((e) => (contentValue.split(',')).any((e1) => e1 == e.id)).toList().cast<FormDynamicFieldOption>().toList();
    FormDynamicFieldOption? selected = selecteds.firstOrNull;
    Widget field = switch (fieldType) {
      FormDynamicFieldType.text => TextCustomField(
          hintText: "Value",
          initialValue: contentValue,
          onChange: (input) {
            fieldDependencyNotifier.onChangeContent(dependId).call(
                  content.copyWith(value: input),
                );
          },
        ),
      FormDynamicFieldType.select => DropdownField<FormDynamicFieldOption>(
          items: fieldOptions,
          multiSelectable: isContain,
          value: isContain ? selecteds : selected,
          onChanged: (items) {
            fieldDependencyNotifier.onChangeContent(dependId).call(
                  content.copyWith(value: items.map((e) => e.id).join(',')),
                );
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
          onChanged: (dateTime) {
            fieldDependencyNotifier.onChangeContent(dependId).call(
                  content.copyWith(value: dateTime),
                );
          },
        ),
      _ => const SizedBox.shrink(),
    };
    return KeyedSubtree(
      key: ValueKey("Content-Value-${content.id}"),
      child: field,
    );
  }
}
