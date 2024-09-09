import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.initialDate,
    this.maxDate,
    this.minDate,
    this.onChanged,
  });

  /// Initial date value
  final DateTime? initialDate;

  /// Maximum date
  final DateTime? maxDate;

  /// Minumum date
  final DateTime? minDate;

  /// When changed [dateTime]
  final void Function(DateTime? dateTime)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      maxDate: maxDate,
      minDate: minDate,
      initialSelectedDate: initialDate,
      headerStyle: const DateRangePickerHeaderStyle(
        backgroundColor: Colors.white,
        textStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      ),
      backgroundColor: Colors.white,
      selectionMode: DateRangePickerSelectionMode.single,
      onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
        final date = dateRangePickerSelectionChangedArgs.value as DateTime?;
        onChanged?.call(date);
      },
    );
  }
}
