import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import '/form/providers/providers.dart';
import '/form/widgets/widgets.dart';

class FormTarget extends ConsumerWidget {
  const FormTarget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = ref.watch(formNotifierProvider.select((e) => e.fields));
    final scrollController = ref.read(formScrollProvider);
    if (fields.isEmpty) return _buildEmptyTarget;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          _buildTargetList(fields),
          _buildTargetFilled(fields),
        ],
      ),
    );
  }

  Widget get _buildEmptyTarget {
    return Consumer(builder: (context, ref, child) {
      final formPreview = ref.read(formFieldPreviewProvider);
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DragCustomTarget(builder: (context, candidateData, rejectedData) {
          bool hasPreview = candidateData.isNotEmpty;
          hasPreview |= formPreview != null && formPreview.dragIndex == formPreview.dropIndex;
          return FormEmptyBox(hasPreview: hasPreview);
        }),
      );
    });
  }

  /// Target list
  Widget _buildTargetList(List<FormDynamicField> fields) {
    return SliverList.separated(
      itemCount: fields.length,
      separatorBuilder: (context, index) => const SizedBox(height: 3.0),
      itemBuilder: (context, index) {
        final field = fields[index];
        final fieldItem = FormFieldItem(index: index, fieldId: field.id);
        return DraggableCard(
          index: index,
          data: field,
          feedback: fieldItem,
          child: DragCustomTarget(
            index: index,
            builder: (context, candidateData, rejectedData) {
              return FormFieldTargetItem(
                isFirst: index == 0,
                isLast: index == fields.length - 1,
                hasPreview: candidateData.isNotEmpty,
                child: fieldItem,
              );
            },
          ),
        );
      },
    );
  }

  /// Display extented bottom
  ///
  Widget _buildTargetFilled(List<FormDynamicField> fields) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: SizedBox(
          height: 30.0,
          width: double.maxFinite,
          child: Consumer(builder: (context, ref, child) {
            final formPreview = ref.watch(formFieldPreviewProvider);
            return DragCustomTarget(builder: (context, candidateData, rejectedData) {
              bool hasPreview = candidateData.isNotEmpty;
              hasPreview |= formPreview != null && formPreview.dragIndex > fields.length - 1;
              if (hasPreview) return const FormFieldGhost(height: double.maxFinite);
              return const SizedBox.shrink();
            });
          }),
        ),
      ),
    );
  }
}
