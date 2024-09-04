import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/constants/constants.dart';
import '/core/widgets/widgets.dart';
import '../../providers/providers.dart';
import '/core/models/models.dart';

class FormDynamicFieldDependContentItem extends ConsumerWidget {
  const FormDynamicFieldDependContentItem({
    super.key,
    required this.fieldId,
    required this.content,
    required this.onChanged,
  });

  /// Target field id
  final String fieldId;

  /// Dependency Content
  ///
  final FormFieldDependencyContent content;

  /// Changed content
  ///
  final void Function(FormFieldDependencyContent content) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkableFields = ref.watch(linkableFieldsProvider(fieldId));
    FormDynamicField? selectedField = linkableFields.firstWhere((e) => e.id == content.fieldId, orElse: () => FormDynamicField(id: "-1"));
    if (selectedField.id == "-1") selectedField = null;
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 200.0,
                child: DropDownField<FormDynamicField>(
                  hintText: "Field",
                  onChanged: (item) => onChanged.call(content.copyWith(fieldId: item?.id)),
                  items: linkableFields,
                  value: selectedField,
                  itemBuilder: (value) => value?.displayName,
                ),
              ),
              if (selectedField != null)
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: _buildDependType(selectedField.type, selectedField.multiSelectable),
                ),
              if (selectedField != null)
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: _buildValue(selectedField),
                ),
            ],
          ),
        ),
        IconCustomButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
          color: ColorConstants.gray600,
          hoveredForegroundColor: ColorConstants.r400,
          hoveredColor: ColorConstants.r50,
        )
      ],
    );
  }

  Widget _buildDependType(FormDynamicFieldType type, bool multiSelectable) {
    List<FormDynamicDependencyType> dependTypes = switch (type) {
      FormDynamicFieldType.checkbox => [],
      FormDynamicFieldType.select when multiSelectable => [FormDynamicDependencyType.contain],
      FormDynamicFieldType.image => [FormDynamicDependencyType.notEMpty, FormDynamicDependencyType.empty],
      _ => FormDynamicDependencyType.values.where((e) => ![FormDynamicDependencyType.contain.index, FormDynamicDependencyType.enabled.index].contains(e.index)).toList(),
    };
    dependTypes.insert(0, FormDynamicDependencyType.enabled);
    final selected = dependTypes.firstWhere((e) => e == content.depend, orElse: () => dependTypes.first);
    return SizedBox(
      width: 130.0,
      child: DropDownField<FormDynamicDependencyType>(
        items: dependTypes,
        value: selected,
        itemBuilder: (value) => value?.title,
        onChanged: (item) {
          onChanged.call(content.copyWith(dependType: item?.index));
        },
      ),
    );
  }

  Widget _buildValue(FormDynamicField field) {
    if ([FormDynamicDependencyType.empty, FormDynamicDependencyType.notEMpty, FormDynamicDependencyType.enabled].contains(content.depend)) return const SizedBox.shrink();

    return Expanded(
      child: TextCustomField(
        initialValue: content.value,
        hintText: "Value",
      ),
    );
  }
}
