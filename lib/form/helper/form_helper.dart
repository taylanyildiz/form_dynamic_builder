import '../../core/models/models.dart';

/// It's there to help manage form fields
///
abstract final class FormHelper {
  /// Make simplify depency of field
  ///
  /// [link]
  /// * check depends
  /// * check all contents of each depend
  ///
  static FormFieldDependencyLink? simplifyDependency(FormFieldDependencyLink link) {
    Iterable<FormFieldDependency> depends = link.depends.map((e) => e.copyWith(contents: e.contents.where((e) => e.fieldId != null).toList())).where((e) => e.contents.isNotEmpty);
    if (depends.isEmpty) return null;
    return link.copyWith(depends: depends.toList());
  }

  /// Make simplify operation of field
  ///
  /// [link]
  /// * check operations
  /// * check all contents of each operation
  ///
  static FormFieldOperationLink? simplifyOperation(FormFieldOperationLink link) {
    Iterable<FormFieldOperation> operations = link.operations.map((e) => e.copyWith(contents: e.contents.where((e) => e.fieldId != null || e.value != null).toList())).where((e) => e.contents.isNotEmpty);
    if (operations.isEmpty) return null;
    return link.copyWith(operations: operations.toList());
  }
}
