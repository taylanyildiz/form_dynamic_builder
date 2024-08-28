import '../models/models.dart';

/// Get Picker mode by [mode]
///
/// default [DateTimePickerMode.dateAndTime]
DateTimePickerMode dateTimePickerMode(int? mode) => DateTimePickerMode.values.firstWhere(
      (e) => e.index == mode,
      orElse: () => DateTimePickerMode.dateAndTime,
    );
