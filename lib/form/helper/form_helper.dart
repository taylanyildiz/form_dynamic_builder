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
    Iterable<FormFieldDependency> depends = link.depends.map((e) => e.copyWith(contents: e.contents.where((e) => e.fieldId != null).toList())).where((e) => e.contents.isNotEmpty);
    if (depends.isEmpty) return null;
    return link.copyWith(depends: depends.toList());
  }
}
