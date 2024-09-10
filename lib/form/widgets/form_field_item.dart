import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_dynamic_builder/core/constants/constants.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '/form/widgets/form-fields/form_fields.dart';
import '/core/data/data.dart';
import '/core/models/models.dart';

class FormFieldItem extends ConsumerWidget {
  const FormFieldItem({
    super.key,
    required this.index,
    required this.fieldId,
  });

  /// Item index
  final int index;

  /// Form Dynamic field unique id
  final String fieldId;

  /// Field holder
  /// depends on [type]

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(formFieldProvider(fieldId));
    final fieldProviderNotifier = ref.read(formFieldProvider(fieldId).notifier);
    final formNotifier = ref.read(formNotifierProvider.notifier);

    FormDynamicFieldHolder holder = formDynamicFieldHolders.firstWhere((e) => e.type == item.type);

    return FormDynamicExpandableCard(
      backgroundColor: item.copied ? ColorConstants.b50 : Colors.white,
      key: ValueKey("expanded-field-item-${item.id}"),
      initialExpanded: item.expanded,
      titleOnly: holder.type == FormDynamicFieldType.header,
      onCopy: () {
        formNotifier.onCopyField(item);
      },
      onDelete: () {
        formNotifier.onDeleteField(item);
      },
      onChangeStatus: (value) {
        fieldProviderNotifier.update((e) => e.copyWith(expanded: value));
      },
      onChangeOrder: (orderIndex) {
        final order = Order.values.firstWhere((e) => e.index == orderIndex);
        formNotifier.onChangeOrder(item, index, order);
      },
      title: item.labelText ?? "-",
      collapsed: FormDynamicFieldCollapsed(
        field: item,
        onChanged: (field) {
          fieldProviderNotifier.update((e) => field);
        },
      ),
      expanded: FormDynamicFieldExpanded(
        field: item,
        onChanged: (field) {
          fieldProviderNotifier.update((e) => field);
        },
      ),
    );
  }
}
