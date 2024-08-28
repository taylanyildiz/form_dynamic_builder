import '../utils/functions.dart';
import 'form_dynamic_dependency_type.dart';
import 'form_dynamic_logic_type.dart';

/// Example: depencies json
/// ```json
///  {
///         "id": 1,
///         "target_field_id": 5,
///         "dependecy_json": {
///           "logic_type": 2,
///           "depends": [
///             {
///               "logic_type": 2,
///               "depends": [
///                 {
///                   "logic_type": 1,
///                   "depend_type": 1,
///                   "value": "1",
///                   "field_id": 7,
///                 },
///                 {
///                   "logic_type": 1,
///                   "depend_type": 2,
///                   "value": "10",
///                   "field_id": 2,
///                 }
///               ],
///             },
///             {
///               "logic_type": 1,
///               "depend_type": 3,
///               // "value": "33",
///               "other_field": 4,
///               "field_id": 3,
///             }
///           ],
///         },
///       }
/// ```
///
class FormDynamicDependency {
  /// Depend id
  final String id;

  /// Dependecy target field id
  final String targetFieldId;

  /// Dependency content
  final FormDynamicDependencyContent content;

  FormDynamicDependency({
    String? id,
    required this.targetFieldId,
    FormDynamicDependencyContent? content,
  })  : id = id ?? uuid,
        content = content ?? FormDynamicDependencyContent();

  FormDynamicDependency copyWith({String? id, String? targetFieldId, FormDynamicDependencyContent? content}) {
    return FormDynamicDependency(
      id: id ?? this.id,
      targetFieldId: targetFieldId ?? this.targetFieldId,
      content: content ?? this.content,
    );
  }

  factory FormDynamicDependency.fromJson(Map<String, dynamic> json) {
    return FormDynamicDependency(
      id: json['id'],
      targetFieldId: json['target_field_id'],
      content: json['dependency_json'] == null ? null : FormDynamicDependencyContent.fromJson(json['dependecy_json']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "target_field_id": targetFieldId,
        "dependency_json": content.toJson(),
      };
}

class FormDynamicDependencyContent {
  /// Dependency id
  final String id;

  /// Logic type
  /// default [FormDynamicLogicType.field]
  final int logicType;

  /// Dependency type
  /// default [FormDynamicDependencyType.empty]
  final int dependType;

  /// Dependecy field id
  final String? fieldId;

  /// Dependecy value
  final String? value;

  /// Dependecy depends
  final List<FormDynamicDependencyContent> depends;

  /// Logic type enum
  /// default [FormDynamicLogicType.field]
  FormDynamicLogicType get logic => FormDynamicLogicType.values.firstWhere(
        (e) => e.index == logicType,
        orElse: () => FormDynamicLogicType.field,
      );

  /// Dependency type enum
  /// default [FormDynamicDependencyType.empty]
  FormDynamicDependencyType get depend => FormDynamicDependencyType.values.firstWhere(
        (e) => dependType == e.index,
        orElse: () => FormDynamicDependencyType.empty,
      );

  FormDynamicDependencyContent({
    String? id,
    int? logicType,
    int? dependType,
    this.fieldId,
    this.value,
    List<FormDynamicDependencyContent>? depends,
  })  : id = id ?? uuid,
        logicType = logicType ?? FormDynamicLogicType.field.index,
        dependType = dependType ?? FormDynamicDependencyType.empty.index,
        depends = depends ?? const <FormDynamicDependencyContent>[];

  FormDynamicDependencyContent copyWith({
    String? id,
    int? logicType,
    int? dependType,
    String? fieldId,
    String? value,
    List<FormDynamicDependencyContent>? depends,
  }) {
    return FormDynamicDependencyContent(
      id: id ?? this.id,
      logicType: logicType ?? this.logicType,
      dependType: dependType ?? this.dependType,
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
      depends: depends ?? this.depends,
    );
  }

  factory FormDynamicDependencyContent.fromJson(Map<String, dynamic> json) {
    return FormDynamicDependencyContent(
      id: json['id'],
      logicType: json['logic_type'],
      dependType: json['depend_type'],
      fieldId: json['field_id'],
      value: json['value'],
      depends: json['depends'] != null ? List.from(json['depends'].map((e) => FormDynamicDependencyContent.fromJson(e))) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "logic_type": logicType,
        "depend_type": dependType,
        "field_id": fieldId,
        "value": value,
        "depends": depends.map((e) => e.toJson()).toList(),
      };
}
