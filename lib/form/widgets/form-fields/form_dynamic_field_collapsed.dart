import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';
import 'form_dynamic_field_selectable_list.dart';
import 'form_dynamic_field_wrap_images.dart';

class FormDynamicFieldCollapsed extends StatelessWidget {
  const FormDynamicFieldCollapsed({
    super.key,
    required this.field,
    required this.onChanged,
  });

  /// Form dynamic field item
  final FormDynamicField field;

  /// Changed field
  final void Function(FormDynamicField filed)? onChanged;

  String get id => field.id;
  String get labelText => field.labelText ?? "";
  String get hintText => field.hintText ?? "";
  String? get value => field.value;
  bool get isRequired => field.mandantory;
  FormDynamicFieldType get type => field.type;
  DateTimePickerMode get pickerMode => field.pickerMode;
  bool get multiSelectable => field.multiSelectable;
  List<FormDynamicFieldOption> get options => field.options;
  List<FormDynamicFieldOption> get selecteds => field.selecteds;
  FormDynamicFieldOption get selected => field.selected;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (type) {
      case FormDynamicFieldType.text:
        child = TextCustomField(
          key: ValueKey(id),
          initialValue: value,
          hintText: "Value",
          onChange: (input) {
            onChanged?.call(field.copyWith(value: input));
          },
        );
      case FormDynamicFieldType.dateTime:
        child = TextDateTimeField(
          mode: pickerMode,
          initialDate: value,
          onChanged: (date) {
            onChanged?.call(field.copyWith(value: date));
          },
        );
      case FormDynamicFieldType.checkbox || FormDynamicFieldType.select when multiSelectable:
        child = FormDynamicFieldSelectableList(
          selecteds: selecteds,
          type: type,
          options: options,
          onChanged: (value) {
            onChanged?.call(field.copyWith(value: value));
          },
        );
      case FormDynamicFieldType.select when !multiSelectable:
        child = DropdownField<FormDynamicFieldOption>(
          items: options,
          value: selected,
          compareBy: (item) => item.id,
          selectedBuilder: (context, selected) => Text(selected.value),
          onChanged: (item) {
            onChanged?.call(field.copyWith(value: item.firstOrNull?.id));
          },
          itemBuilder: (_, value, selected) {
            return ListTile(
              selected: selected,
              title: Text(value.value),
            );
          },
        );
      case FormDynamicFieldType.image:
        child = FormDynamicFieldWrapImages(
          options: options,
          onChanged: (options) {
            onChanged?.call(field.copyWith(options: options));
          },
        );
      default:
        child = const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRequired) const Text("*", style: TextStyle(color: Colors.red)),
        child,
      ],
    );
  }
}
