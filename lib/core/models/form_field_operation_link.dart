import 'package:equatable/equatable.dart';
import '../utils/functions.dart';
import 'form_dynamic_operation_depend_type.dart';
import 'form_dynamic_operation_type.dart';

class FormFieldOperationLink with EquatableMixin {
  /// Operation id
  ///
  final String id;

  /// Operation target field id
  ///
  final String targetFieldId;

  /// Link card is expanded
  ///
  /// default [false]
  ///
  /// it's not about dependency link
  final bool isExpanded;

  /// Operation type
  ///
  /// default index of [FormDynamicOperationType.addition]
  final int operationType;

  /// Field depend contents
  ///
  /// It gives [targetFieldId] depend which fields and which depend
  final List<FormFieldOperaiton> operations;

  /// Operation type enum
  ///
  /// default [FormDynamicOperationType.addition]
  FormDynamicOperationType get logic => FormDynamicOperationType.values.firstWhere(
        (e) => e.index == operationType,
        orElse: () => FormDynamicOperationType.addition,
      );

  FormFieldOperationLink({
    String? id,
    required this.targetFieldId,
    bool? isExpanded,
    int? operationType,
    List<FormFieldOperaiton>? operations,
  })  : id = id ?? uuid,
        isExpanded = isExpanded ?? false,
        operationType = operationType ?? FormDynamicOperationType.addition.index,
        operations = operations ?? const <FormFieldOperaiton>[];

  FormFieldOperationLink copyWith({
    String? id,
    String? targetFieldId,
    bool? isExpanded,
    int? operationType,
    List<FormFieldOperaiton>? operations,
  }) {
    return FormFieldOperationLink(
      id: id ?? this.id,
      targetFieldId: targetFieldId ?? this.targetFieldId,
      isExpanded: isExpanded ?? this.isExpanded,
      operationType: operationType ?? this.operationType,
      operations: operations ?? [],
    );
  }

  factory FormFieldOperationLink.fromJson(Map<String, dynamic> json) {
    var link = FormFieldOperationLink(
      id: json['id'],
      targetFieldId: json['target_field_id'],
      operationType: json['operation_type'],
    );
    if (json['operations'] != null) {
      final operations = List<FormFieldOperaiton>.from(json['depends'].map((e) => FormFieldOperaiton.fromJson(e)));
      link = link.copyWith(operations: operations);
    }
    return link;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "target_field_id": targetFieldId,
        "operations": operations.map((e) => e.toJson()).toList(),
        "operation_type": operationType,
      };

  @override
  List<Object?> get props => [
        id,
        targetFieldId,
        isExpanded,
        operationType,
      ];
}

class FormFieldOperaiton with EquatableMixin {
  /// Operation unique id
  ///
  final String id;

  /// Field operation contents
  ///
  final List<FormFieldOperationContent> contents;

  /// Operation type
  ///
  /// default index of [FormDynamicOperationType.addition]
  final int operationType;

  /// Operation type enum
  ///
  /// default [FormDynamicOperationType.addition]
  FormDynamicOperationType get logic => FormDynamicOperationType.values.firstWhere(
        (e) => e.index == operationType,
        orElse: () => FormDynamicOperationType.addition,
      );

  FormFieldOperaiton({
    String? id,
    List<FormFieldOperationContent>? contents,
    int? operationType,
  })  : id = id ?? uuid,
        contents = contents ?? const <FormFieldOperationContent>[],
        operationType = operationType ?? FormDynamicOperationType.addition.index;

  FormFieldOperaiton copyWith({
    String? id,
    List<FormFieldOperationContent>? contents,
    int? operationType,
  }) {
    return FormFieldOperaiton(
      id: id ?? this.id,
      contents: contents ?? this.contents,
      operationType: operationType ?? this.operationType,
    );
  }

  factory FormFieldOperaiton.fromJson(Map<String, dynamic> json) {
    var operation = FormFieldOperaiton(
      id: json['id'],
      operationType: json['operation_type'],
    );
    if (json['contents'] != null) {
      final contents = List<FormFieldOperationContent>.from(json['contents'].map((e) => FormFieldOperationContent.fromJson(e)));
      operation = operation.copyWith(contents: contents);
    }
    return operation;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "contents": contents.map((e) => e.toJson()).toList(),
        "operation_type": operationType,
      };

  @override
  List<Object?> get props => [
        id,
        contents,
        operationType,
      ];
}

class FormFieldOperationContent with EquatableMixin {
  /// Operation content unique id
  ///
  final String id;

  /// Depend field id
  ///
  final String? fieldId;

  /// Operation depend type
  ///
  /// default [FormDynamicOperationDependType.handle]
  final int dependType;

  /// If [dependType] is [FormDynamicOperationDependType.value]
  ///
  ///
  final String? value;

  /// Depend type enum
  ///
  FormDynamicOperationDependType get depend => FormDynamicOperationDependType.values.firstWhere(
        (e) => e.index == dependType,
        orElse: () => FormDynamicOperationDependType.handle,
      );

  FormFieldOperationContent({
    String? id,
    this.fieldId,
    int? dependType,
    this.value,
  })  : id = id ?? uuid,
        dependType = dependType ?? FormDynamicOperationDependType.handle.index;

  FormFieldOperationContent copyWith({
    String? id,
    String? fieldId,
    int? dependType,
    String? value,
  }) {
    return FormFieldOperationContent(
      id: id ?? this.id,
      fieldId: fieldId ?? (depend == FormDynamicOperationDependType.field ? this.fieldId : null),
      dependType: dependType ?? this.dependType,
      value: value ?? (depend == FormDynamicOperationDependType.handle ? this.value : null),
    );
  }

  factory FormFieldOperationContent.fromJson(Map<String, dynamic> json) {
    return FormFieldOperationContent(
      id: json['id'],
      fieldId: json['field_id'],
      dependType: json['depend_type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "field_id": fieldId,
        "depend_type": dependType,
        "value": value,
      };

  @override
  List<Object?> get props => [
        id,
        dependType,
        value,
      ];
}
