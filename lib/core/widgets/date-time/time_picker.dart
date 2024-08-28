import 'package:flutter/cupertino.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
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
    return CupertinoDatePicker(
      use24hFormat: true,
      minimumDate: minDate,
      maximumDate: maxDate?.copyWith(
        hour: initialDate != null ? (initialDate!.hour + 1) : null,
      ),
      initialDateTime: initialDate ?? maxDate,
      mode: CupertinoDatePickerMode.time,
      onDateTimeChanged: (date) => onChanged?.call(date),
    );
  }
}
