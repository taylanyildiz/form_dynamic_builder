import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';

class FormDynamicTextField extends StatelessWidget {
  const FormDynamicTextField({super.key, required this.field, this.withLabel = false});

  /// Display label
  ///
  /// default [false]
  final bool withLabel;

  /// Dynamic field
  final FormDynamicField field;

  // Field type
  FormDynamicFieldType get type => field.type;

  // field id
  String get id => field.id;

  // field label text
  String get labelText => field.labelText ?? "";

  // field hint text
  String get hintText => field.hintText ?? "";

  // field value
  String? get value => field.value;

  // field is required
  bool get mandantory => field.mandantory;

  // field picker mode
  DateTimePickerMode get pickerMode => field.pickerMode;

  // field multiselectable
  bool get multiSelectable => field.multiSelectable;

  // field options
  List<FormDynamicFieldOption> get options => field.options;

  // field selecteds from [options]
  List<FormDynamicFieldOption> get selecteds => field.selecteds;

  // field selecgted
  FormDynamicFieldOption get selected => field.selected;

  @override
  Widget build(BuildContext context) {
    Widget child = switch (type) {
      FormDynamicFieldType.header => const SizedBox.shrink(),
      FormDynamicFieldType.text => TextCustomField(
          labelText: withLabel ? labelText : null,
          hintText: hintText,
          initialValue: value,
          mandantory: mandantory,
        ),
      FormDynamicFieldType.checkbox => CheckboxGroup(
          itemCount: options.length,
          selected: (index) => selecteds.contains(options[index]),
          onChanged: (index, value) {},
          itemBuilder: (index) {
            final option = options[index];
            return option.value;
          },
        ),
      FormDynamicFieldType.dateTime => TextDateTimeField(
          mandantory: mandantory,
          labelText: withLabel ? labelText : null,
          hintText: hintText,
          initialDate: value,
          onChanged: (dateTime) {},
        ),
      FormDynamicFieldType.select when !multiSelectable => DropDownField(
          labelText: withLabel ? labelText : null,
          items: options,
          value: selected,
          onChanged: (item) {},
          itemBuilder: (value) {
            return value?.value;
          },
        ),
      FormDynamicFieldType.select => SizedBox(
          height: 150.0,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: const BorderSide(),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: options.length,
              separatorBuilder: (context, index) => const SizedBox(),
              itemBuilder: (context, index) {
                final option = options[index];
                return ListTile(
                  onTap: () {},
                  selected: selecteds.contains(option),
                  title: Text(option.value),
                );
              },
            ),
          ),
        ),
      FormDynamicFieldType.image => Wrap(
          children: List.generate(options.length, (index) {
            final option = options[index];
            return ImageCard(
              image: option.value,
              onChanged: (image) {},
              onDelete: () {},
            );
          }),
        ),
    };
    return child;
  }
}
