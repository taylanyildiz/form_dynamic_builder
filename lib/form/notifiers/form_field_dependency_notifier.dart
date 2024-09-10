import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/helper/form_helper.dart';
import '../providers/providers.dart';
import '/core/models/models.dart';

/// Field dependency notifier
///
/// argument represents target field unique id
class FormFieldDependencyNotifier extends AutoDisposeFamilyNotifier<FormFieldDependencyLink, String> {
  /// Listen depend field id
  ///
  ProviderSubscription? subscription;

  @override
  FormFieldDependencyLink build(String arg) {
    // default field dependency link
    final defaultLink = FormFieldDependencyLink(targetFieldId: arg);

    final depend = ref.read(formFieldProvider(arg).select((e) => e.dependencyLink));
    return depend ?? defaultLink;
  }

  @override
  set state(FormFieldDependencyLink value) {
    ref.read(formFieldProvider(arg).notifier).update((e) => e.setDependency(FormHelper.simplifyDependency(value)));
    super.state = value;
  }

  /// Changed card expanded status
  ///
  void onChangedCardStatus(bool status) {
    if (status) ref.read(formFieldProvider(arg).notifier).update((e) => e.copyWith(enabled: false));
    state = state.copyWith(isExpanded: status);
  }

  /// Clear all depends
  ///
  void Function()? onClearAll() {
    if (state.depends.isEmpty) return null;
    return () => state = state.copyWith(depends: []);
  }

  /// Clear all contents
  ///
  void Function()? onClearContents(String dependId) {
    if (state.depends.firstWhere((e) => e.id == dependId).contents.isEmpty) return null;
    return () {
      final depends = [...state.depends];
      depends.removeWhere((e) => e.id == dependId);
      state = state.copyWith(depends: depends);
    };
  }

  /// Add dependency
  ///
  void onAddDependency() {
    state = state.copyWith(
      depends: [
        ...state.depends,
        FormFieldDependency(contents: [FormFieldDependencyContent()]),
      ],
    );
  }

  /// Add dependency content
  ///
  void onAddContent(String dependId) {
    final depends = [...state.depends];
    final index = depends.indexWhere((e) => e.id == dependId);
    if (index == -1) return;
    final contents = depends[index].contents;
    depends[index] = depends[index].copyWith(contents: [...contents, FormFieldDependencyContent()]);
    state = state.copyWith(depends: depends);
  }

  /// Target logic type changed
  ///
  void onChangeTargetLogicType(FormDynamicLogicType type) {
    state = state.copyWith(logicType: type.index);
  }

  /// Content logic type changed
  ///
  void Function(FormDynamicLogicType type) onChangeDepenLogicType(String dependId) {
    return (type) {
      final depends = [...state.depends];
      final index = depends.indexWhere((e) => e.id == dependId);
      if (index == -1) return;
      depends[index] = depends[index].copyWith(logicType: type.index);
      state = state.copyWith(depends: depends);
    };
  }

  /// Any field changed in content
  void Function(FormFieldDependencyContent content) onChangeContent(String dependId) {
    return (content) {
      // find depends
      final depends = [...state.depends];
      final dependIndex = depends.indexWhere((e) => e.id == dependId);
      if (dependIndex == -1) return;

      // find contents
      final contents = [...depends[dependIndex].contents];
      final contentIndex = contents.indexWhere((e) => e.id == content.id);
      if (contentIndex == -1) return;

      // Changed depend type
      // value set to [null]
      if (contents[contentIndex].dependType != content.dependType) {
        content = content.copyWithNull(value: true);
      }

      // Changed field
      // value set to null
      // depen-type set to [FormDynamicDependencyType.empty]
      if (contents[contentIndex].fieldId != content.fieldId) {
        subscription?.close();
        content = content.copyWithNull(value: true);
        content = content.copyWith(dependType: FormDynamicDependencyType.empty.index);
        subscription = ref.listen(formFieldProvider(content.fieldId!), (previous, next) {
          if (!listEquals(previous?.options, next.options)) {
            if (next.type == FormDynamicFieldType.select) {
              final values = content.value.split(',');
              if (values.isNotEmpty) {
                for (var value in values) {
                  if (next.options.any((e) => e.id != value)) {
                    values.remove(value);
                  }
                }
                content = content.copyWith(value: values.join(','));
              }
              ref.notifyListeners();
            }
          }
        });
      }

      // update content
      contents[contentIndex] = content;

      // update depends
      depends[dependIndex] = depends[dependIndex].copyWith(contents: contents);
      state = state.copyWith(depends: depends);
    };
  }

  /// Delete specified content
  ///
  void onDeleteContent(String dependId, String contentId) {
    final depends = [...state.depends];
    int dependIndex = depends.indexWhere((e) => e.id == dependId);
    if (dependIndex == -1) return;

    final contents = [...depends[dependIndex].contents];
    if (contents.length <= 1) {
      // Delete depend
      depends.removeAt(dependIndex);
    } else {
      int contentIndex = contents.indexWhere((e) => e.id == contentId);
      if (contentIndex == -1) return;
      contents.removeAt(contentIndex);
      depends[dependIndex] = depends[dependIndex].copyWith(contents: contents);
    }

    state = state.copyWith(depends: depends);
  }
}
