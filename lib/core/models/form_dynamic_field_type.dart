enum FormDynamicFieldType {
  /// Header
  header(1),

  /// text field
  text(2),

  /// checkbox
  checkbox(3),

  /// Date-Time
  dateTime(4),

  /// Select
  select(5),

  /// Image
  image(6),
  ;

  final int type;
  const FormDynamicFieldType(this.type);

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
