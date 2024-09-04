import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '/core/models/models.dart';

class FormFieldDependencyNotifier extends AutoDisposeFamilyNotifier<FormFieldDependencyLink, String> {
  @override
  FormFieldDependencyLink build(String arg) {
    final defaultLink = FormFieldDependencyLink(targetFieldId: arg);
    final depends = ref.read(formNotifierProvider.select((e) => e.dependencies));
    return depends.firstWhere((e) => e.targetFieldId == arg, orElse: () => defaultLink);
  }

  void Function()? onClearAll() {
    if (state.depends.isEmpty) return null;
    return () => state = state.copyWith(depends: []);
  }

  void Function()? onClearContents(String dependId) {
    if (state.depends.firstWhere((e) => e.id == dependId).contents.isEmpty) return null;
    return () {
      final depends = [...state.depends];
      depends.removeWhere((e) => e.id == dependId);
      state = state.copyWith(depends: depends);
    };
  }

  void onAddDependency() {
    state = state.copyWith(
      depends: [
        ...state.depends,
        FormFieldDependency(contents: [FormFieldDependencyContent()]),
      ],
    );
  }

  void onAddContent(String dependId) {
    final depends = [...state.depends];
    final index = depends.indexWhere((e) => e.id == dependId);
    if (index == -1) return;
    final contents = depends[index].contents;
    depends[index] = depends[index].copyWith(contents: [...contents, FormFieldDependencyContent()]);
    state = state.copyWith(depends: depends);
  }

  void onChangeTargetLogicType(FormDynamicLogicType type) {
    state = state.copyWith(logicType: type.index);
  }

  void Function(FormDynamicLogicType type) onChangeDepenLogicType(String dependId) {
    return (type) {
      final depends = [...state.depends];
      final index = depends.indexWhere((e) => e.id == dependId);
      if (index == -1) return;
      depends[index] = depends[index].copyWith(logicType: type.index);
      state = state.copyWith(depends: depends);
    };
  }

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

      // update content
      contents[contentIndex] = content;

      // update depends
      depends[dependIndex] = depends[dependIndex].copyWith(contents: contents);
      state = state.copyWith(depends: depends);
    };
  }
}
