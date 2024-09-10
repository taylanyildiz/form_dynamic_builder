import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';

class FormFieldLogicTypeSelect extends StatelessWidget {
  const FormFieldLogicTypeSelect({
    super.key,
    bool? editable,
    required this.logicType,
    required this.onChanged,
  }) : editable = editable ?? true;

  /// Can change logic type
  ///
  /// default [true]
  final bool editable;

  /// Selected logic type
  ///
  final FormDynamicLogicType logicType;

  /// When changed selected
  ///
  /// depends on [editable] when true
  final void Function(FormDynamicLogicType type) onChanged;

  void Function(int index)? _onChanged() {
    if (!editable) return null;
    return (index) => onChanged.call(FormDynamicLogicType.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SpinButton(
      itemCount: FormDynamicLogicType.values.length,
      selectedIndex: logicType.index,
      onChanged: _onChanged(),
      itemBuilder: (context, index) {
        final type = FormDynamicLogicType.values[index];
        return Text(type.title);
      },
    );
  }
}
