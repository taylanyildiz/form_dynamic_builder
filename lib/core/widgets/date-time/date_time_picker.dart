import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_dynamic_builder/core/extensions/date_extensions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
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
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: SfDateRangePicker(
            headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Colors.white,
              textStyle: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            backgroundColor: Colors.white,
            maxDate: maxDate,
            minDate: minDate,
            initialSelectedDate: initialDate,
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              final date = dateRangePickerSelectionChangedArgs.value as DateTime?;
              DateTime? dateTime = initialDate.updateDate(date);
              onChanged?.call(dateTime ?? date);
            },
          ),
        ),
        SizedBox(
          width: 100.0,
          child: CupertinoDatePicker(
            use24hFormat: true,
            minimumDate: minDate,
            maximumDate: maxDate?.copyWith(
              hour: initialDate != null ? (initialDate!.hour + 1) : null,
            ),
            initialDateTime: initialDate ?? maxDate,
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (date) {
              DateTime? dateTime = initialDate.updateTime(date);
              onChanged?.call(dateTime ?? date);
            },
          ),
        ),
      ],
    );
  }
}
