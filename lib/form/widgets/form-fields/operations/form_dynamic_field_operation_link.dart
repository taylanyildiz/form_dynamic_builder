import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import '/core/constants/constants.dart';
import '/core/widgets/widgets.dart';
import '../../../providers/providers.dart';
import 'form_dynamic_field_operation_content_item.dart';

class FormDynamicFieldOperationLink extends ConsumerWidget {
  const FormDynamicFieldOperationLink({
    super.key,
    required this.fieldId,
  });

  /// Specified field unique id
  ///
  final String fieldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final field = ref.watch(formFieldProvider(fieldId));
    final fieldNotifier = ref.read(formFieldProvider(fieldId).notifier);

    final fieldOperation = ref.watch(formFieldOperationProvider(fieldId));
    final fieldOperationNotifier = ref.read(formFieldOperationProvider(fieldId).notifier);

    return ExpandableCard.builder(
      key: ValueKey("operation-field-card-$fieldId"),
      onExpansionChanged: fieldOperationNotifier.onChangedCardStatus,
      initiallyExpanded: fieldOperation.isExpanded,
      builder: (controller) {
        return ExpandableCustomCardDelegate(
          title: Label(
            label: "Value",
            child: Row(
              children: [
                Expanded(
                  child: TextCustomField(
                    initialValue: field.value,
                    onChange: (input) {
                      fieldNotifier.update((e) => e.copyWith(value: input));
                    },
                  ),
                ),
                const SizedBox(width: 5.0),
                Tooltip(
                  message: "Dependency Link",
                  child: IconCustomButton(
                    onPressed: () {
                      controller.toggle();
                    },
                    hoveredColor: const Color.fromARGB(255, 163, 214, 255),
                    icon: const Icon(Icons.add_link),
                  ),
                ),
              ],
            ),
          ),
          children: [
            Card(
              margin: const EdgeInsets.only(left: 130.0, top: 5.0),
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Operations",
                            style: textTheme.titleMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: fieldOperationNotifier.onClearAll(),
                          child: const Text("Clear all"),
                        ),
                      ],
                    ),
                    _buildOperations,
                    const SizedBox(height: 10.0),
                    PrimaryButton(
                      minimumSize: Size.zero,
                      onPressed: fieldOperationNotifier.onAddOperation,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(7.0),
                      radius: 3.0,
                      borderSide: BorderSide(width: 1.0, color: ColorConstants.gray200),
                      title: "Add Operation",
                      titleStyle: textTheme.titleMedium?.copyWith(
                        fontSize: 13.0,
                      ),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildOperations {
    return Consumer(builder: (context, ref, child) {
      final fieldOperationNotifier = ref.read(formFieldOperationProvider(fieldId).notifier);
      final fieldOperation = ref.watch(formFieldOperationProvider(fieldId));

      final targetOperationType = fieldOperation.operation;
      final operations = fieldOperation.operations;

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fieldOperation.operations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 3.0),
        itemBuilder: (context, index) {
          final operation = fieldOperation.operations[index];
          final contents = operation.contents;
          Widget card = Card(
            color: ColorConstants.gray100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contents.length + 1,
              separatorBuilder: (context, index) => const SizedBox(height: 3.0),
              itemBuilder: (context, index) {
                if (index == contents.length) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                        minimumSize: Size.zero,
                        onPressed: () => fieldOperationNotifier.onAddContent(operation.id),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(7.0),
                        borderSide: BorderSide.none,
                        title: "Add Nested Operation",
                        icon: const Icon(Icons.add),
                      ),
                      TextButton(
                        onPressed: fieldOperationNotifier.onClearContents(operation.id),
                        child: const Text("Clear all"),
                      ),
                    ],
                  );
                }
                final content = contents[index];

                return Row(
                  children: [
                    if (contents.length > 1) ...[
                      SizedBox(
                        width: 100.0,
                        child: DropdownField(
                          enabled: index == 0,
                          onChanged: (items) {
                            fieldOperationNotifier.onChangeOperationType.call(operation.id).call(items.first);
                          },
                          compareBy: (item) => item.title,
                          items: FormDynamicOperationType.values,
                          value: operation.operation,
                          itemBuilder: (context, item, selected) {
                            return ListTile(
                              selected: selected,
                              title: Text(item.title),
                            );
                          },
                        ),
                      ),
                    ],
                    const SizedBox(width: 3.0),
                    Expanded(
                      child: FormDynamicFieldOperationContentItem(
                        key: ValueKey("content-item-${content.id}"),
                        fieldId: fieldId, // Target field id
                        operationId: operation.id,
                        content: content,
                      ),
                    )
                  ],
                );
              },
            ),
          );

          return Row(
            children: [
              if (operations.length > 1) ...[
                SizedBox(
                  width: 100,
                  child: DropdownField(
                    enabled: index == 0,
                    onChanged: (items) {
                      fieldOperationNotifier.onChangeTargetOperationType.call(items.first);
                    },
                    compareBy: (item) => item.title,
                    items: FormDynamicOperationType.values,
                    value: targetOperationType,
                    itemBuilder: (context, item, selected) {
                      return ListTile(
                        selected: selected,
                        title: Text(item.title),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(width: 3.0),
              Expanded(child: card),
            ],
          );
        },
      );
    });
  }
}
