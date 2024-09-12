import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/form_helper.dart';
import '/form/providers/providers.dart';
import '/core/models/models.dart';

/// Form field operation notifier
///
/// argument represent field unique id
class FormFieldOperationNotifier extends AutoDisposeFamilyNotifier<FormFieldOperationLink, String> {
  @override
  FormFieldOperationLink build(String arg) {
    final operationLink = ref.read(formFieldProvider(arg).select((e) => e.operationLink));
    return operationLink ?? FormFieldOperationLink(targetFieldId: arg);
  }

  @override
  set state(FormFieldOperationLink value) {
    ref.read(formFieldProvider(arg).notifier).update((e) => e.setOperation(FormHelper.simplifyOperation(value)));
    super.state = value;
  }

  /// Changed card expanded status
  ///
  void onChangedCardStatus(bool status) {
    if (status) ref.read(formFieldProvider(arg).notifier).update((e) => e.copyWith(value: ""));
    state = state.copyWith(isExpanded: status);
  }

  /// Clear all operatios
  ///
  void Function()? onClearAll() {
    if (state.operations.isEmpty) return null;
    return () => state = state.copyWith(operations: []);
  }

  /// Clear all contents
  ///
  void Function()? onClearContents(String operationId) {
    if (state.operations.firstWhere((e) => e.id == operationId).contents.isEmpty) return null;
    return () {
      final operations = [...state.operations];
      operations.removeWhere((e) => e.id == operationId);
      state = state.copyWith(operations: operations);
    };
  }

  /// Add operation
  ///
  void onAddOperation() {
    final operations = [...state.operations];
    operations.add(FormFieldOperation(contents: [FormFieldOperationContent()]));
    state = state.copyWith(operations: operations);
  }

  /// Add operation content
  ///
  void onAddContent(String operationId) {
    final operations = [...state.operations];
    final index = operations.indexWhere((e) => e.id == operationId);
    if (index == -1) return;
    final contents = operations[index].contents;
    operations[index] = operations[index].copyWith(contents: [...contents, FormFieldOperationContent()]);
    state = state.copyWith(operations: operations);
  }

  /// Target operation type changed
  ///
  void onChangeTargetOperationType(FormDynamicOperationType type) {
    state = state.copyWith(operationType: type.index);
  }

  /// Content logic type changed
  ///
  void Function(FormDynamicOperationType type) onChangeOperationType(String operationId) {
    return (type) {
      final operations = [...state.operations];
      final index = operations.indexWhere((e) => e.id == operationId);
      if (index == -1) return;
      operations[index] = operations[index].copyWith(operationType: type.index);
      state = state.copyWith(operations: operations);
    };
  }

  /// Any field changed in content
  ///
  void Function(FormFieldOperationContent content) onChangeContent(String operationId) {
    return (content) {
      // find operations
      final operations = [...state.operations];
      final operationIndex = operations.indexWhere((e) => e.id == operationId);
      if (operationIndex == -1) return;

      // find contents
      final contents = [...operations[operationIndex].contents];
      final contentIndex = contents.indexWhere((e) => e.id == content.id);
      if (contentIndex == -1) return;

      // Changed operation type
      if (contents[contentIndex].dependType != content.dependType) {
        if (content.depend == FormDynamicOperationDependType.handle) {
          content = content.copyWithNull(fieldId: true);
        }

        if (content.depend == FormDynamicOperationDependType.field) {
          content = content.copyWithNull(value: true);
        }
      }

      // update content
      contents[contentIndex] = content;

      // update depends
      operations[operationIndex] = operations[operationIndex].copyWith(contents: contents);
      state = state.copyWith(operations: operations);
    };
  }

  /// Delete specified content
  ///
  void onDeleteContent(String operationId, String contentId) {
    final operations = [...state.operations];
    int operationIndex = operations.indexWhere((e) => e.id == operationId);
    if (operationIndex == -1) return;

    final contents = [...operations[operationIndex].contents];
    if (contents.length <= 1) {
      // Delete operation
      operations.removeAt(operationIndex);
    } else {
      int contentIndex = contents.indexWhere((e) => e.id == contentId);
      if (contentIndex == -1) return;
      contents.removeAt(contentIndex);
      operations[operationIndex] = operations[operationIndex].copyWith(contents: contents);
    }

    state = state.copyWith(operations: operations);
  }
}
