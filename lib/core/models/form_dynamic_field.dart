import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../utils/enum_helper.dart';
import '/core/models/models.dart';
import '../utils/functions.dart';
import 'form_field_operation_link.dart';

class FormDynamicField with EquatableMixin {
  /// Field id
  /// generated automaticly by [uuid]
  final String id;

  /// Field display name
  ///
  /// default name of [type]
  final String displayName;

  /// Field type
  /// default [FormDynamicFieldType.text]
  final int fieldType;

  /// Field Ordered number
  final int seq;

  /// Field label text
  final String? labelText;

  /// Field hint text
  final String? hintText;

  /// Field value
  /// if [fieldType] is selectable or checkbox
  /// value seems like 1,2, came from [options]
  final String? value;

  /// If field is [text]
  /// maximum length
  final int? maxLength;

  /// Minimum length
  final int? minLength;

  /// If field is [text]
  /// maximum lines
  final int maxLines;

  /// If field is [text]
  /// minumum lines
  final int? minLines;

  /// Is required to fill field
  /// default [false]
  final bool mandantory;

  /// Depends on [type] if selectable
  /// default [false]
  final bool multiSelectable;

  /// Can editable field
  /// default [true]
  final bool canEdit;

  /// Field is enabled
  ///
  /// default [true]
  /// If is not [true] must be check has any link to enabled
  final bool enabled;

  /// Field permission
  /// default [FormDynamicPermission.both]
  final int permissionType;

  /// Depends on [fieldType] is date
  /// default [DateTimePickerMode.dateAndTime]
  /// 0 => DateTime.date,
  /// 1 => DateTimePickerMode.date,
  /// 2 => DateTimePickerMode.dateAndTime,
  final int? pickerModeType;

  /// Field options
  /// if [fieldType] is [select] or [checkbox]
  final List<FormDynamicFieldOption> options;

  /// Field dependency link
  ///
  final FormFieldDependencyLink? dependencyLink;

  /// Field operation link
  ///
  final FormFieldOperationLink? operationLink;

  /// Field is expanded
  /// default [false]
  final bool expanded;

  /// If field copied default set to true
  ///
  /// default [false]
  final bool copied;

  /// If field is checkbox or multible select
  /// selecteds items depends on [value]
  List<FormDynamicFieldOption> get selecteds {
    final values = value?.split(",") ?? [];
    return List<FormDynamicFieldOption>.from(options).where((option) => values.any((value) => value == option.id)).toList();
  }

  /// If field is single selectable select
  FormDynamicFieldOption get selected {
    return List.from(options).firstWhere((option) => value == option.id, orElse: () => options.first);
  }

  /// Field type
  ///
  /// default [FormDynamicFieldType.text]
  FormDynamicFieldType get type => FormDynamicFieldType.values.firstWhere(
        (e) => e.index == fieldType,
        orElse: () => FormDynamicFieldType.text,
      );

  /// If [fieldType] is date
  /// have [pickerModeType]
  DateTimePickerMode get pickerMode => dateTimePickerMode(pickerModeType);

  /// Permission type enum
  ///
  FormDynamicPermission get permission => FormDynamicPermission.values.firstWhere((e) => e.index == permissionType);

  FormDynamicField({
    String? id,
    String? displayName,
    int? fieldType,
    int? seq,
    this.labelText,
    this.hintText,
    this.value,
    this.maxLength,
    this.minLength,
    int? maxLines,
    this.minLines,
    bool? mandantory,
    bool? multiSelectable,
    this.pickerModeType,
    List<FormDynamicFieldOption>? options,
    bool? canEdit,
    int? permissionType,
    bool? expanded,
    bool? enabled,
    bool? copied,
    this.dependencyLink,
    this.operationLink,
  })  : id = id ?? uuid,
        fieldType = fieldType ?? FormDynamicFieldType.text.index,
        seq = seq ?? 0,
        maxLines = maxLines ?? 1,
        mandantory = mandantory ?? false,
        multiSelectable = multiSelectable ?? false,
        options = options ?? const <FormDynamicFieldOption>[],
        canEdit = canEdit ?? true,
        permissionType = permissionType ?? FormDynamicPermission.both.index,
        expanded = expanded ?? false,
        enabled = enabled ?? true,
        displayName = displayName ?? generateFieldName(fieldType),
        copied = copied ?? false;

  FormDynamicField copyWith({
    String? id,
    String? displayName,
    int? fieldType,
    int? seq,
    String? labelText,
    String? hintText,
    String? value,
    int? maxLength,
    int? minLength,
    int? maxLines,
    int? minLines,
    bool? mandantory,
    bool? multiSelectable,
    int? pickerMode,
    List<FormDynamicFieldOption>? options,
    bool? canEdit,
    int? permissionType,
    bool? expanded,
    bool? enabled,
    FormFieldDependencyLink? dependencyLink,
    FormFieldOperationLink? operationLink,
    bool? copied,
  }) {
    return FormDynamicField(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      fieldType: fieldType ?? this.fieldType,
      seq: seq ?? this.seq,
      labelText: labelText ?? this.labelText,
      hintText: hintText ?? this.hintText,
      value: value ?? this.value,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      mandantory: mandantory ?? this.mandantory,
      multiSelectable: multiSelectable ?? this.multiSelectable,
      pickerModeType: pickerMode ?? pickerModeType,
      options: options ?? this.options,
      canEdit: canEdit ?? this.canEdit,
      permissionType: permissionType ?? this.permissionType,
      expanded: expanded ?? this.expanded,
      enabled: enabled ?? this.enabled,
      dependencyLink: dependencyLink ?? this.dependencyLink,
      operationLink: operationLink ?? this.operationLink,
      copied: copied ?? this.copied,
    );
  }

  FormDynamicField dublicate() {
    final field = copyWith(id: uuid, expanded: false);
    if (field.multiSelectable || field.type == FormDynamicFieldType.checkbox) {
      final values = field.value?.split(',') ?? [];
      final copyOptions = List<FormDynamicFieldOption>.from([]);
      final copyValues = List<String>.from([]);
      final index = field.options.indexWhere((e) => values.any((e1) => e1 == e.id));
      if (index != -1) {
        copyOptions.add(options[index].copyWith(id: uuid));
        copyValues.add(options[index].id);
      }
      field.copyWith(value: copyValues.join(','), options: copyOptions);
    }
    final encoded = jsonEncode({
      ...field.toJson(),
      "dependency_link": null,
      "operation_link": null,
    });
    final decoded = FormDynamicField.fromJson(jsonDecode(encoded));
    return decoded.copyWith(copied: true);
  }

  FormDynamicField setDependency(FormFieldDependencyLink? link) {
    FormDynamicField field = copyWith();
    final encoded = jsonEncode({...field.toJson(), "dependency_link": link});
    final decoded = FormDynamicField.fromJson(jsonDecode(encoded));
    return decoded.copyWith(expanded: field.expanded);
  }

  FormDynamicField setOperation(FormFieldOperationLink? link) {
    FormDynamicField field = copyWith();
    final encoded = jsonEncode({...field.toJson(), "operation_link": link});
    final decoded = FormDynamicField.fromJson(jsonDecode(encoded));
    return decoded.copyWith(expanded: field.expanded);
  }

  factory FormDynamicField.fromJson(Map<String, dynamic> json) {
    FormDynamicField field = FormDynamicField(
      id: json['id'],
      displayName: json['display_name'],
      fieldType: json['field_type'],
      seq: json['seq'],
      enabled: json['enabled'],
      labelText: json['label_text'],
      hintText: json['hint_text'],
      value: json['value'],
      maxLength: json['max_length'],
      minLength: json['min_length'],
      maxLines: json['max_lines'],
      minLines: json['min_lines'],
      mandantory: json['mandantory'],
      multiSelectable: json['multi_selectable'],
      canEdit: json['can_edit'],
      permissionType: json['permission_type'],
      pickerModeType: json['picker_mode_type'],
    );

    if (json['options'] != null) {
      final options = List<FormDynamicFieldOption>.from(json['options'].map((e) => FormDynamicFieldOption.fromJson(e)));
      field = field.copyWith(options: options);
    }

    if (json['dependency_link'] != null) {
      field = field.copyWith(
        dependencyLink: FormFieldDependencyLink.fromJson(json['dependency_link']),
      );
    }

    if (json['operation_link'] != null) {
      field = field.copyWith(
        operationLink: FormFieldOperationLink.fromJson(json['operation_link']),
      );
    }
    return field;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "field_type": fieldType,
        "seq": seq,
        "enabled": enabled,
        "label_text": labelText,
        "hint_text": hintText,
        "value": value,
        "max_length": maxLength,
        "min_length": minLength,
        "max_lines": maxLines,
        "min_lines": minLines,
        "mandantory": mandantory,
        "multi_selectable": multiSelectable,
        "can_edit": canEdit,
        "permission_type": permissionType,
        "picker_mode_type": pickerModeType,
        "options": options.map((e) => e.toJson()).toList(),
        "dependency_link": dependencyLink?.toJson(),
        "operation_link": operationLink?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        displayName,
        fieldType,
        seq,
        labelText,
        hintText,
        value,
        maxLength,
        maxLines,
        minLines,
        mandantory,
        multiSelectable,
        options,
        enabled,
        copied,
      ];
}
