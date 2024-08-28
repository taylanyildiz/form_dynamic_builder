import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '/core/constants/constants.dart';

extension DateExtension on DateTime? {
  /// Date Time localization
  /// 2 different mode selection [onlyDate] doesn't give time
  String? locale({bool onlyDate = false, bool withDay = false, bool onlyTime = false}) {
    if (this == null) return null;
    String languageCode = Localizations.localeOf(NavigatorConstants.context).languageCode;
    if (onlyTime) return DateFormat('HH:mm', languageCode).format(this!);
    String format = "MMM d, yyyy";
    if (!onlyDate) format += ", HH:mm";
    if (withDay) format = "EEEE, $format";
    return DateFormat(format, languageCode).format(this!);
  }

  /// Get Only Time
  String? getTime() {
    if (this == null) return null;
    String formattedTime = DateFormat.Hm().format(this!);
    return formattedTime;
  }

  /// Get Only Date
  String? getDate() {
    if (this == null) return null;
    String formattedDate = DateFormat("y-MM-dd").format(this!);
    return formattedDate;
  }

  /// Date to string by [mode]
  String? toModeString(DateTimePickerMode mode) {
    if (this == null) return null;
    return switch (mode) {
      DateTimePickerMode.time => getTime(),
      DateTimePickerMode.date => getDate(),
      DateTimePickerMode.dateAndTime => toString().split(".").first,
    };
  }
}
