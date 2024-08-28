enum FormDynamicFieldType {
  // none(0),
  header(1),
  text(2),
  checkbox(3),
  dateTime(4),
  select(5),
  image(6),
  ;

  final int type;
  const FormDynamicFieldType(this.type);
}
