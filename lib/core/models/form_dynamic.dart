import '../utils/functions.dart';
import 'form_dynamic_field.dart';
import 'form_field_dependency_link.dart';

class FormDynamic {
  /// Dynamic form id
  /// default [uuid]
  final String id;

  /// Form name
  ///
  final String? name;

  /// Form fields
  final List<FormDynamicField> fields;

  FormDynamic({
    String? id,
    this.name,
    List<FormDynamicField>? fields,
    List<FormFieldDependencyLink>? dependencies,
  })  : id = id ?? uuid,
        fields = fields ?? const <FormDynamicField>[];

  FormDynamic copyWith({
    String? id,
    String? name,
    List<FormDynamicField>? fields,
  }) {
    return FormDynamic(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields ?? this.fields,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fields": fields.map((e) => e.toJson()).toList(),
      };
}
