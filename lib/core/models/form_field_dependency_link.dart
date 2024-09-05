import 'package:equatable/equatable.dart';
import '../utils/functions.dart';
import 'form_dynamic_dependency_type.dart';
import 'form_dynamic_logic_type.dart';

/// Dependency expample
/// ```json
// {
///   "id": 1,
///   "target_field_id": 1,
///   "logic_type": 1,
///   "depends": [
///     {
///       "logic_type": 2,
///       "depends": [{}, {}]
///     },
///     {
///       "logic_type": 1,
///       "depends": [
///         {
///           "depend_type": 1,
///           "field_id": 2,
///           "value": 3
///         }
///       ]
///     }
///   ]
/// }
/// ```
class FormFieldDependencyLink with EquatableMixin {
  /// Depend id
  final String id;

  /// Dependecy target field id
  final String targetFieldId;

  /// Link card is expanded
  ///
  /// default [false]
  ///
  /// it's not about dependency link
  final bool isExpanded;

  /// Logic type
  ///
  /// default index of [FormDynamicLogicType.and]
  final int logicType;

  /// Field depend contents
  ///
  /// It gives [targetFieldId] depend which fields and which depend
  final List<FormFieldDependency> depends;

  /// Logic type enum
  /// default [FormDynamicLogicType.and]
  FormDynamicLogicType get logic => FormDynamicLogicType.values.firstWhere(
        (e) => e.index == logicType,
        orElse: () => FormDynamicLogicType.and,
      );

  FormFieldDependencyLink({
    String? id,
    bool? isExpanded,
    required this.targetFieldId,
    int? logicType,
    List<FormFieldDependency>? depends,
  })  : id = id ?? uuid,
        isExpanded = isExpanded ?? false,
        logicType = logicType ?? FormDynamicLogicType.and.index,
        depends = depends ?? const <FormFieldDependency>[];

  FormFieldDependencyLink copyWith({
    String? id,
    bool? isExpanded,
    String? targetFieldId,
    int? logicType,
    List<FormFieldDependency>? depends,
  }) {
    return FormFieldDependencyLink(
      id: id ?? this.id,
      isExpanded: isExpanded ?? this.isExpanded,
      targetFieldId: targetFieldId ?? this.targetFieldId,
      logicType: logicType ?? this.logicType,
      depends: depends ?? this.depends,
    );
  }

  factory FormFieldDependencyLink.fromJson(Map<String, dynamic> json) {
    FormFieldDependencyLink link = FormFieldDependencyLink(
      id: json['id'],
      targetFieldId: json['target_field_id'],
      logicType: json['logic_type'],
    );
    if (json['depends'] != null) {
      final depends = List<FormFieldDependency>.from(json['depends'].map((e) => FormFieldDependency.fromJson(e)));
      link = link.copyWith(depends: depends);
    }
    return link;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "target_field_id": targetFieldId,
        "logic_type": logicType,
        "depends": depends.map((e) => e.toJson()),
      };

  @override
  List<Object?> get props => [
        id,
        targetFieldId,
        logicType,
        depends,
      ];
}

class FormFieldDependency with EquatableMixin {
  /// Dependency unique id
  final String id;

  /// Logic type
  ///
  /// default index of [FormDynamicLogicType.and]
  final int logicType;

  /// Dependency field content
  ///
  /// It gives fields how to depend
  final List<FormFieldDependencyContent> contents;

  /// Logic type enum
  /// default [FormDynamicLogicType.and]
  FormDynamicLogicType get logic => FormDynamicLogicType.values.firstWhere(
        (e) => e.index == logicType,
        orElse: () => FormDynamicLogicType.and,
      );

  FormFieldDependency({
    String? id,
    int? logicType,
    List<FormFieldDependencyContent>? contents,
  })  : id = id ?? uuid,
        logicType = logicType ?? FormDynamicLogicType.and.index,
        contents = contents ?? [];

  FormFieldDependency copyWith({
    String? id,
    int? logicType,
    List<FormFieldDependencyContent>? contents,
  }) {
    return FormFieldDependency(
      id: id ?? this.id,
      logicType: logicType ?? this.logicType,
      contents: contents ?? this.contents,
    );
  }

  factory FormFieldDependency.fromJson(Map<String, dynamic> json) {
    FormFieldDependency dependency = FormFieldDependency(
      id: json['id'],
      logicType: json['logic_type'],
    );
    if (json['contents'] != null) {
      final depends = List<FormFieldDependencyContent>.from(json['contents'].map((e) => FormFieldDependencyContent.fromJson(e)));
      dependency = dependency.copyWith(contents: depends);
    }
    return dependency;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "logic_type": logicType,
        "contents": contents.map((e) => e.toJson()),
      };

  @override
  List<Object?> get props => [
        id,
        logicType,
        contents,
      ];
}

class FormFieldDependencyContent with EquatableMixin {
  /// Depend unique id
  final String id;

  /// Dependency type
  ///
  /// default index of [FormDynamicDependencyType.empty]
  final int dependType;

  /// Depend field id
  final String? fieldId;

  /// Field Depend value
  final String? value;

  /// Dependency type enum
  /// default [FormDynamicDependencyType.empty]
  FormDynamicDependencyType get depend => FormDynamicDependencyType.values.firstWhere(
        (e) => dependType == e.index,
        orElse: () => FormDynamicDependencyType.empty,
      );

  FormFieldDependencyContent({
    String? id,
    int? dependType,
    this.fieldId,
    this.value,
  })  : id = id ?? uuid,
        dependType = dependType ?? FormDynamicDependencyType.empty.index;

  FormFieldDependencyContent copyWith({
    String? id,
    int? dependType,
    String? fieldId,
    String? value,
  }) {
    return FormFieldDependencyContent(
      id: id ?? this.id,
      dependType: dependType ?? this.dependType,
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
    );
  }

  factory FormFieldDependencyContent.fromJson(Map<String, dynamic> json) {
    return FormFieldDependencyContent(
      id: json['id'],
      dependType: json['depend_type'],
      fieldId: json['field_id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "depend_type": dependType,
        "field_id": fieldId,
        "value": value,
      };

  @override
  List<Object?> get props => [id, dependType, fieldId, value];
}
