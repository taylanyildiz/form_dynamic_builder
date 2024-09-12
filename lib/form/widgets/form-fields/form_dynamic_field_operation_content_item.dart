import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_dynamic_builder/core/widgets/widgets.dart';
import '../../../core/constants/constants.dart';
import '../../providers/providers.dart';
import '/core/models/models.dart';

class FormDynamicFieldOperationContentItem extends ConsumerWidget {
  const FormDynamicFieldOperationContentItem({
    super.key,
    required this.fieldId,
    required this.content,
    required this.onChanged,
    required this.onDelete,
  });

  /// Field unique id
  ///
  final String fieldId;

  /// Operation content
  final FormFieldOperationContent content;

  /// Changed content
  ///
  final void Function(FormFieldOperationContent content) onChanged;

  /// Delete content
  ///
  final void Function() onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkableFields = ref.watch(operationLinkableFieldsProvider(fieldId));
    FormDynamicField? selectedField = linkableFields.firstWhere((e) => e.id == content.fieldId, orElse: () => FormDynamicField(id: "-1"));
    if (selectedField.id == "-1") selectedField = null;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: DropdownField(
                  compareBy: (item) => item.title,
                  onChanged: (items) => onChanged.call(content.copyWith(dependType: items.firstOrNull?.index)),
                  items: FormDynamicOperationDependType.values,
                  value: content.depend,
                  itemBuilder: (context, item, selected) {
                    return ListTile(
                      selected: selected,
                      title: Text(item.title),
                    );
                  },
                ),
              ),
              const SizedBox(width: 4.0),
              if (content.depend == FormDynamicOperationDependType.handle) ...[
                Expanded(
                  child: TextCustomField(
                    hintText: "Value",
                    initialValue: content.value,
                    onChange: (input) => onChanged.call(content.copyWith(value: input)),
                  ),
                ),
              ],
              if (content.depend == FormDynamicOperationDependType.field) ...[
                Expanded(
                  child: DropdownField(
                    items: linkableFields,
                    value: selectedField,
                    onChanged: (items) => onChanged.call(content.copyWith(fieldId: items.firstOrNull?.id)),
                    compareBy: (item) => item.displayName,
                    itemBuilder: (context, item, selected) {
                      return ListTile(
                        selected: selected,
                        title: Text(item.displayName),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 4.0),
        IconCustomButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          color: ColorConstants.gray600,
          hoveredForegroundColor: ColorConstants.r400,
          hoveredColor: ColorConstants.r50,
        )
      ],
    );
  }
}
