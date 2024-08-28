enum FormDynamicPermission {
  none(0),
  mobile(1),
  web(2),
  both(3),
  ;

  final int type;
  const FormDynamicPermission(this.type);

  String get title {
    return switch (this) {
      FormDynamicPermission.none => "None",
      FormDynamicPermission.mobile => "Only Mobile",
      FormDynamicPermission.web => "Only Web",
      FormDynamicPermission.both => "Web and Mobile",
    };
  }
}
