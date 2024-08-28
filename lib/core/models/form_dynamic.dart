import '../utils/functions.dart';
import 'form_dynamic_dependency.dart';
import 'form_dynamic_field.dart';

class FormDynamic {
  /// Dynamic form id
  /// default [uuid]
  final String id;

  /// Form fields
  final List<FormDynamicField> fields;

  /// Form dynamic dependencies
  final List<FormDynamicDependency> dependencies;

  FormDynamic({
    String? id,
    List<FormDynamicField>? fields,
    List<FormDynamicDependency>? dependencies,
  })  : id = id ?? uuid,
        fields = fields ?? const <FormDynamicField>[],
        dependencies = dependencies ?? const <FormDynamicDependency>[];

  FormDynamic copyWith({
    String? id,
    List<FormDynamicField>? fields,
    List<FormDynamicDependency>? dependencies,
  }) {
    return FormDynamic(
      id: id ?? this.id,
      fields: fields ?? this.fields,
      dependencies: dependencies ?? this.dependencies,
    );
  }
}
