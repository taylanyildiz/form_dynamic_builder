import '../models/models.dart';

FormDynamicField get defaultFormHeader => FormDynamicField(
      fieldType: FormDynamicFieldType.header.type,
      labelText: "Header",
    );

FormDynamicField get defaultFormText => FormDynamicField(
      fieldType: FormDynamicFieldType.text.type,
      labelText: "Text Field",
      hintText: "Enter Text",
    );

FormDynamicField get defaultFormCheckbox {
  final options = [FormDynamicFieldOption(value: "Option 1")];
  return FormDynamicField(
    multiSelectable: true,
    fieldType: FormDynamicFieldType.checkbox.type,
    labelText: "Checkbox",
    value: [options.first.id].join(','),
    options: options,
  );
}

FormDynamicField get defaultFormDateTime => FormDynamicField(
      fieldType: FormDynamicFieldType.dateTime.type,
      labelText: "Date-Time Field",
      value: DateTime.now().toString().split('.').first,
      pickerModeType: DateTimePickerMode.dateAndTime.index,
    );

FormDynamicField get defaultFormSelect {
  final options = [
    FormDynamicFieldOption(value: "Option 1"),
    FormDynamicFieldOption(value: "Option 2"),
  ];
  return FormDynamicField(
    fieldType: FormDynamicFieldType.select.type,
    labelText: "Select",
    value: [options.first.id].join(','),
    options: options,
  );
}

FormDynamicField get defaultFromImage {
  return FormDynamicField(
    fieldType: FormDynamicFieldType.image.type,
    options: [FormDynamicFieldOption()],
    labelText: "Image",
    multiSelectable: false,
  );
}

FormDynamicField defaultFormDynamicField(FormDynamicFieldType type) {
  return switch (type) {
    FormDynamicFieldType.header => defaultFormHeader,
    FormDynamicFieldType.text => defaultFormText,
    FormDynamicFieldType.checkbox => defaultFormCheckbox,
    FormDynamicFieldType.dateTime => defaultFormDateTime,
    FormDynamicFieldType.select => defaultFormSelect,
    FormDynamicFieldType.image => defaultFromImage,
  };
}
