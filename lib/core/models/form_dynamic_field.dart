import 'package:equatable/equatable.dart';
import 'package:form_generator/core/models/form_dynamic_permission.dart';
import '../utils/enum_helper.dart';
import '/core/models/models.dart';
import '../utils/functions.dart';

class FormDynamicField with EquatableMixin {
  /// Field id
  /// generated automaticly by [uuid]
  final String id;

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

  /// Field is expanded
  /// default [false]
  final bool expanded;

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
        (e) => e.type == fieldType,
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
  })  : id = id ?? uuid,
        fieldType = fieldType ?? FormDynamicFieldType.text.type,
        seq = seq ?? 0,
        maxLines = maxLines ?? 1,
        mandantory = mandantory ?? false,
        multiSelectable = multiSelectable ?? false,
        options = options ?? const <FormDynamicFieldOption>[],
        canEdit = canEdit ?? true,
        permissionType = permissionType ?? FormDynamicPermission.both.index,
        expanded = expanded ?? false;

  FormDynamicField copyWith(
      {String? id,
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
      bool? expanded}) {
    return FormDynamicField(
      id: id ?? this.id,
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
    return field;
  }

  @override
  List<Object?> get props => [
        id,
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
      ];

  Map<String, dynamic> toJson() => {
        "id": id,
        "field_type": fieldType,
        "seq": seq,
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
      };
}
