import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '/core/models/models.dart';

class DraggableCard extends ConsumerWidget {
  const DraggableCard({
    super.key,
    required this.index,
    required this.child,
    required this.feedback,
    required this.data,
  });

  /// List item index
  final int index;

  /// Child
  final Widget child;

  /// When child drag preview child
  final Widget feedback;

  /// Data drag
  final FormDynamicField data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(formNotifierProvider.notifier);
    final formFieldPreviewNotifier = ref.read(formFieldPreviewProvider.notifier);
    final formFieldPreview = ref.read(formFieldPreviewProvider);
    return LayoutBuilder(builder: (_, constraints) {
      final width = constraints.maxWidth;
      return LongPressDraggable<FormDynamicField>(
        hapticFeedbackOnStart: false,
        onDragStarted: () {
          formFieldPreviewNotifier.update((e) => e?.copyWith(dropIndex: index));
        },
        onDragCompleted: () {
          if (formFieldPreview == null) formNotifier.onAddField();
        },
        onDraggableCanceled: (_, __) {
          formFieldPreviewNotifier.update((e) => e?.copyWith(dragIndex: e.dropIndex));
          formNotifier.onAddField();
        },
        feedback: Opacity(
          opacity: 0.95,
          child: SizedBox(width: width, child: feedback),
        ),
        data: data,
        child: child,
      );
    });
  }
}
