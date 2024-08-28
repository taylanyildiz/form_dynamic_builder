enum DateTimePickerMode {
  /// Only displaying date
  ///
  date,

  /// Only displaying time
  time,

  /// Date and Time
  dateAndTime,
  ;

  /// Title
  String get title => switch (this) {
        DateTimePickerMode.date => "Date",
        DateTimePickerMode.time => "Time",
        DateTimePickerMode.dateAndTime => "Date And Time",
      };
}
