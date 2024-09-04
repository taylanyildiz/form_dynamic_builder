import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/constants/constants.dart';
import '/form/providers/providers.dart';
import '/core/widgets/widgets.dart';
import 'form_dynamic_field_depend_content_item.dart';
import 'form_field_logic_type_select.dart';

class FormDynamicFieldDependencyLink extends ConsumerWidget {
  const FormDynamicFieldDependencyLink({
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

    final fieldDependency = ref.watch(formFieldDependencyProvider(fieldId));
    final fieldDependencyNotifier = ref.read(formFieldDependencyProvider(fieldId).notifier);

    return ExpandableCustomCard(
      title: (controller) => Label(
        label: "Enabled",
        child: Row(
          children: [
            Checkbox(
              value: field.enabled,
              onChanged: (value) {
                fieldNotifier.update((e) => e.copyWith(enabled: value));
              },
            ),
            Tooltip(
              message: "Link",
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
        Row(
          children: [
            Expanded(
              child: Text(
                "Dependencies",
                style: textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: fieldDependencyNotifier.onClearAll(),
              child: const Text("Clear all"),
            ),
          ],
        ),
        _buildDependencies,
        const SizedBox(height: 10.0),
        PrimaryButton(
          minimumSize: Size.zero,
          onPressed: () => fieldDependencyNotifier.onAddDependency(),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(7.0),
          radius: 3.0,
          borderSide: BorderSide(width: 1.0, color: ColorConstants.gray200),
          title: "Add Dependency",
          titleStyle: textTheme.titleMedium?.copyWith(
            fontSize: 13.0,
          ),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget get _buildDependencies {
    return Consumer(builder: (context, ref, child) {
      final fieldDependencyNotifier = ref.read(formFieldDependencyProvider(fieldId).notifier);

      // field dependency
      final fieldDependency = ref.watch(formFieldDependencyProvider(fieldId));
      final targetLogicType = fieldDependency.logic;
      final depends = fieldDependency.depends;

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: depends.length,
        separatorBuilder: (context, index) => const SizedBox(height: 3.0),
        itemBuilder: (context, index) {
          final depend = depends[index];
          final contents = depend.contents;
          Widget card = Card(
            color: ColorConstants.gray100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
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
                        onPressed: () => fieldDependencyNotifier.onAddContent(depend.id),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(7.0),
                        borderSide: BorderSide.none,
                        title: "Add Nested Dependency",
                        icon: const Icon(Icons.add),
                      ),
                      TextButton(
                        onPressed: fieldDependencyNotifier.onClearContents(depend.id),
                        child: const Text("Clear all"),
                      ),
                    ],
                  );
                }
                final content = contents[index];
                final contentItem = FormDynamicFieldDependContentItem(
                  key: ValueKey("content-item-${content.id}"),
                  fieldId: fieldId, // Target field id
                  content: content,
                  onChanged: fieldDependencyNotifier.onChangeContent(depend.id),
                );
                if (contents.length > 1) {
                  return Row(
                    children: [
                      FormFieldLogicTypeSelect(
                        logicType: depend.logic,
                        editable: index == 0,
                        onChanged: fieldDependencyNotifier.onChangeDepenLogicType(depend.id),
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(child: contentItem),
                    ],
                  );
                }
                return contentItem;
              },
            ),
          );

          if (depends.length > 1) {
            return Row(
              children: [
                FormFieldLogicTypeSelect(
                  logicType: targetLogicType,
                  editable: index == 0,
                  onChanged: fieldDependencyNotifier.onChangeTargetLogicType,
                ),
                const SizedBox(width: 4.0),
                Expanded(child: card),
              ],
            );
          }
          return card;
        },
      );
    });
  }
}
