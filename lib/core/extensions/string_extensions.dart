import '../models/models.dart';

extension StringNullTypeExtension on String? {
  /// Convert to [DateTime]
  DateTime? get toDate {
    if (this == null) return null;
    try {
      return DateTime.parse(this!.trim());
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Paser time to date
  DateTime? parserTimeToDate() {
    try {
      if (this == null) return null;
      try {
        return DateTime.parse(this!.trim());
      } catch (error) {
        final splitData = this!.split(":");
        if (splitData.length < 2) return null;
        final h = int.parse(splitData[0]);
        final m = int.parse(splitData[1]);
        return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, h, m);
      }
    } catch (error) {
      return null;
    }
  }

  /// Date parser to string by [mode]
  DateTime? toModeDate(DateTimePickerMode mode) {
    final date = this ?? DateTime.now().toString();
    final data = switch (mode) {
      DateTimePickerMode.time => date.parserTimeToDate(),
      _ => toDate,
    };
    return data;
  }
}
