import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/models/types.dart';
import '/form/providers/providers.dart';
import '/core/models/models.dart';

class DragCustomTarget extends ConsumerWidget {
  const DragCustomTarget({
    super.key,
    this.index,
    required this.builder,
  });

  /// Target item index
  final int? index;

  /// Builder child
  final Widget Function(BuildContext context, List<FormDynamicField?> candidateData, List<dynamic> rejectedData) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(formNotifierProvider.notifier);
    final fields = ref.read(formNotifierProvider.select((e) => e.fields));
    final formFieldPreviewNotifier = ref.read(formFieldPreviewProvider.notifier);
    return DragTarget<FormDynamicField>(
      onLeave: index == null ? null : (data) => formNotifier.jumpToScroll(index!),
      onAcceptWithDetails: (details) {
        formNotifier.onAddField(details.data);
      },
      onMove: (details) {
        if (fields.isEmpty) return;
        final data = details.data;
        if (index == null) {
          formFieldPreviewNotifier.update((e) => e?.copyWith(dragIndex: fields.length));
          return;
        } else {
          final defaultPreview = (index: index!, dragIndex: index!, dropIndex: -1, field: data);
          formFieldPreviewNotifier.update((e) => e?.copyWith(dragIndex: index) ?? defaultPreview);
        }
        formNotifier.onMove();
      },
      builder: builder,
    );
  }
}
