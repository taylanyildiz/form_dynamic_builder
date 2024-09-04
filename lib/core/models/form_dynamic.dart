import '../utils/functions.dart';
import 'form_dynamic_field.dart';
import 'form_field_dependency_link.dart';

class FormDynamic {
  /// Dynamic form id
  /// default [uuid]
  final String id;

  /// Form fields
  final List<FormDynamicField> fields;

  /// Form dynamic dependencies
  final List<FormFieldDependencyLink> dependencies;

  FormDynamic({
    String? id,
    List<FormDynamicField>? fields,
    List<FormFieldDependencyLink>? dependencies,
  })  : id = id ?? uuid,
        fields = fields ?? const <FormDynamicField>[],
        dependencies = dependencies ?? const <FormFieldDependencyLink>[];

  FormDynamic copyWith({
    String? id,
    List<FormDynamicField>? fields,
    List<FormFieldDependencyLink>? dependencies,
  }) {
    return FormDynamic(
      id: id ?? this.id,
      fields: fields ?? this.fields,
      dependencies: dependencies ?? this.dependencies,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fields": fields.map((e) => e.toJson()).toList(),
        "dependency_links": dependencies.map((e) => e.toJson()).toList(),
      };
}
