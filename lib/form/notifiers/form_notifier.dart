import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/dialog/app_dialog.dart';
import '/form/pages/pages.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '/core/models/models.dart';

class FormNotifier extends Notifier<FormDynamic> {
  @override
  FormDynamic build() {
    return FormDynamic();
  }

  /// When Accept data
  void onAddField([FormDynamicField? field]) {
    final fieldPreview = ref.read(formFieldPreviewProvider);
    final fields = [...state.fields];
    int index = fieldPreview?.dragIndex ?? (fields.isEmpty ? 0 : fields.length);

    field ??= fieldPreview?.field;
    if (field == null) return;

    fields.insert(index, field);
    ref.read(formFieldPreviewProvider.notifier).update((e) => null);
    state = state.copyWith(fields: fields);
  }

  /// Move item
  void onMove() {
    final fieldPreview = ref.read(formFieldPreviewProvider);
    if (fieldPreview == null) return;

    // If has no dropped
    if (!state.fields.contains(fieldPreview.field) || fieldPreview.dropIndex == -1) return;

    // copied fields from states
    List<FormDynamicField> fields = [...state.fields];

    // If dropped item remove from fields
    fields.removeAt(fieldPreview.dropIndex);
    state = state.copyWith(fields: fields);
  }

  /// Copied item then insert last
  void onCopyField(FormDynamicField field) {
    state = state.copyWith(
      fields: [
        ...state.fields,
        field.dublicate(),
      ],
    );
  }

  /// Delete field item
  void onDeleteField(FormDynamicField field) {
    List<FormDynamicField> fields = [...state.fields];
    fields = fields.where((e) => e.id != field.id).toList();
    state = state.copyWith(fields: fields);
  }

  /// Change order
  void onChangeOrder(FormDynamicField field, index, Order order) {
    final fields = [...state.fields];
    if ((index == 0 && order == Order.up) || (index == state.fields.length - 1 && order == Order.down)) return;
    fields.removeAt(index);
    switch (order) {
      case Order.up:
        fields.insert(index - 1, field);
      case Order.down:
        fields.insert(index + 1, field);
    }
    state = state.copyWith(fields: fields);
  }

  /// Save fields
  void Function()? onSave() {
    if (state.fields.isEmpty) return null;
    return () {
      ref.read(formPageProvider).jumpToPage(FormPages.saved.index);
    };
  }

  /// Display json code
  void Function()? onDisplay() {
    if (state.fields.isEmpty) return null;
    return () {
      AppDialog.openDialog(const FormJsonDialog());
    };
  }

  /// Clear all
  void Function()? onClear() {
    if (state.fields.isEmpty) return null;
    return () {
      state = state.copyWith(fields: []);
    };
  }

  /// Scroll to dragged index
  void jumpToScroll(int index) {
    final scrollController = ref.read(formScrollProvider);
    if (scrollController.hasClients && state.fields.length > 1) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent / (state.fields.length - 1) * index);
    }
  }
}
