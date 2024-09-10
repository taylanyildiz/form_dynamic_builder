enum FormDynamicFieldType {
  /// Header
  header,

  /// text field
  text,

  /// checkbox
  checkbox,

  /// Date-Time
  dateTime,

  /// Select
  select,

  /// Image
  image,
  ;

  /// Title of
  String get title => switch (this) {
        FormDynamicFieldType.header => "Header",
        FormDynamicFieldType.text => "Text",
        FormDynamicFieldType.checkbox => "Checkbox",
        FormDynamicFieldType.dateTime => "Date-Time",
        FormDynamicFieldType.select => "Select",
        FormDynamicFieldType.image => "Image",
      };
}
