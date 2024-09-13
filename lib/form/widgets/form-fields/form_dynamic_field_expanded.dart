import 'package:flutter/material.dart';
import '/core/constants/constants.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';
import 'dependencies/dependencies.dart';
import 'operations/operations.dart';

class FormDynamicFieldExpanded extends StatelessWidget {
  const FormDynamicFieldExpanded({
    super.key,
    required this.field,
    required this.onChanged,
  });

  /// Form Dynamic field object
  final FormDynamicField field;

  /// Field when changed
  final void Function(FormDynamicField field)? onChanged;

  // field id
  String get id => field.id;

  // field display name
  String get displayName => field.displayName;

  // enabled condition
  bool get enabled => field.enabled;

  // label text
  String get labelText => field.labelText ?? "";

  // hint text
  String get hintText => field.hintText ?? "";

  // value
  String? get value => field.value;

  // Is required
  bool get mandantory => field.mandantory;

  // field type enum
  FormDynamicFieldType get type => field.type;

  // picker mode if field is date - time
  DateTimePickerMode get pickerMode => field.pickerMode;

  // Is multi selectable
  // If field is checkbox or select type
  bool get multiSelectable => field.multiSelectable;

  // field options if field is checkbox or select type
  List<FormDynamicFieldOption> get options => field.options;

  // field selected options
  List<FormDynamicFieldOption> get selecteds => field.selecteds;

  // field selected option if field is select type and not multi-selectable
  FormDynamicFieldOption get selected => field.selected;

  // field is header
  bool get isHeaderType => type == FormDynamicFieldType.header;

  // field is checkbox
  bool get isCheckboxType => type == FormDynamicFieldType.checkbox;

  // field is select
  bool get isSelectType => type == FormDynamicFieldType.select;

  // field is text-field
  bool get isTextType => type == FormDynamicFieldType.text;

  // field is date-tiem
  bool get isDateTimeType => type == FormDynamicFieldType.dateTime;

  @override
  Widget build(BuildContext context) {
    return ColumnSeparator(
      separatorBuilder: (index) => const SizedBox(height: 3.0),
      children: [
        _buildDisplayNameField,
        Builder(
          builder: (context) {
            if (isHeaderType) return _buildLabelTextField;
            return ColumnSeparator(
              separatorBuilder: (index) => const SizedBox(height: 3.0),
              children: [
                if (!(isCheckboxType || (isSelectType && !multiSelectable))) _buildRequiredField,
                if (!isHeaderType) FormDynamicFieldDependencyLink(fieldId: id),
                _buildLabelTextField,
                _buildHintTextField,
                if (isDateTimeType) _buildPickerMode,
                if (isDateTimeType) _buildDateTimePicker,
                if (isTextType) _buildTextValueField,
                if (isCheckboxType || isSelectType) _buildOptions,
              ],
            );
          },
        )
      ],
    );
  }

  Widget get _buildDisplayNameField {
    return Label(
      label: "Display Name",
      child: TextCustomField(
        initialValue: displayName,
        onChange: (input) => onChanged?.call(field.copyWith(displayName: input)),
      ),
    );
  }

  Widget get _buildRequiredField {
    return Label(
      label: "Required",
      child: Checkbox(
        value: mandantory,
        onChanged: (value) => onChanged?.call(field.copyWith(mandantory: value)),
      ),
    );
  }

  Widget get _buildLabelTextField {
    return Label(
      label: "Label Text",
      child: TextCustomField(
        initialValue: labelText,
        onChange: (input) => onChanged?.call(field.copyWith(labelText: input)),
      ),
    );
  }

  Widget get _buildHintTextField {
    return Label(
      label: "Hint Text",
      child: TextCustomField(
        initialValue: hintText,
        onChange: (input) => onChanged?.call(field.copyWith(hintText: input)),
      ),
    );
  }

  Widget get _buildPickerMode {
    return Label(
      label: "Type",
      child: DropdownField(
        items: DateTimePickerMode.values,
        selectedBuilder: (context, selected) => Text(selected.title),
        value: pickerMode,
        onChanged: (value) {
          onChanged?.call(field.copyWith(pickerMode: value.firstOrNull?.index));
        },
        itemBuilder: (_, value, selected) {
          return ListTile(
            selected: selected,
            title: Text(value.title),
          );
        },
      ),
    );
  }

  Widget get _buildDateTimePicker {
    return Label(
      label: "Value",
      child: TextDateTimeField(
        mode: pickerMode,
        initialDate: value,
        onChanged: (date) {
          onChanged?.call(field.copyWith(value: date));
        },
      ),
    );
  }

  Widget get _buildTextValueField {
    return FormDynamicFieldOperationLink(
      fieldId: field.id,
    );
  }

  Widget get _buildOptions {
    return ColumnSeparator(
      crossAxisAlignment: CrossAxisAlignment.end,
      separatorBuilder: (index) => const SizedBox(height: 3.0),
      children: [
        if (isSelectType)
          Label(
            label: "",
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              value: multiSelectable,
              title: const Text("Allow Multiple Selections"),
              onChanged: (value) {
                var copyField = field.copyWith(multiSelectable: value);
                if (value == false && isSelectType && selecteds.length > 1) {
                  copyField = copyField.copyWith(value: selecteds.first.id);
                }
                onChanged?.call(copyField);
              },
            ),
          ),
        Label(
          crossAxisAlignment: CrossAxisAlignment.start,
          label: "Options",
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: BorderSide(color: ColorConstants.gray100),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                bool selected = selecteds.contains(option);
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: Checkbox(
                    onChanged: (selectedValue) {
                      List<FormDynamicFieldOption> copySelecteds = List.from(selecteds);
                      if (selectedValue == true) {
                        if (!multiSelectable) copySelecteds.clear();
                        copySelecteds.add(option);
                      }
                      if (selectedValue == false) {
                        final removed = copySelecteds.removeAt(selecteds.indexOf(option));
                        if (!multiSelectable) copySelecteds.add(removed);
                      }
                      final value = copySelecteds.map((e) => e.id).toList().join(',');
                      onChanged?.call(field.copyWith(value: value));
                    },
                    value: selected,
                  ),
                  title: TextCustomField(
                    key: ValueKey("Field-Option-${option.id}"),
                    initialValue: option.value,
                    onChange: (input) {
                      List<FormDynamicFieldOption> copyOptions = List.from(options);
                      copyOptions[index] = copyOptions[index].copyWith(value: input);
                      onChanged?.call(field.copyWith(options: copyOptions));
                    },
                  ),
                  trailing: (() {
                    if ((isCheckboxType && options.length <= 1) || (isSelectType && options.length <= 2) || selected) return null;
                    return IconButton(
                      onPressed: () {
                        List<FormDynamicFieldOption> copyOptions = List.from(options);
                        copyOptions.removeAt(index);
                        onChanged?.call(field.copyWith(options: copyOptions));
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.close),
                    );
                  }()),
                );
              },
            ),
          ),
        ),
        PrimaryButton(
          minimumSize: Size.zero,
          padding: const EdgeInsets.all(12.0),
          onPressed: () {
            onChanged?.call(field.copyWith(options: [...options, FormDynamicFieldOption()]));
          },
          title: "Add Option",
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
