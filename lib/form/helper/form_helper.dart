import '../../core/models/models.dart';

/// It's there to help manage form fields
///
abstract final class FormHelper {
  /// Make simplif depency of field
  ///
  /// [link]
  /// * check depends
  /// * check all contents of each depends
  static FormFieldDependencyLink? simplifyDependency(FormFieldDependencyLink link) {
    final depends = [...link.depends];
    final allContens = depends.expand((e) => e.contents);
    if (depends.isEmpty || allContens.isEmpty) return null;

    for (var index = 0; index < depends.length; index++) {
      final depend = depends[index];
      final contents = [...depend.contents];

      if (contents.isEmpty) {
        depends.removeAt(index);
        continue;
      }

      for (FormFieldDependencyContent content in contents) {
        if (content.fieldId == null) {
          contents.remove(content);
          if (contents.isEmpty) {
            depends.removeAt(index);
            continue;
          }
          depends[index] = depends[index].copyWith(contents: contents);
        }
      }
    }
    if (depends.isEmpty) return null;
    return link.copyWith(depends: depends);
  }
}
