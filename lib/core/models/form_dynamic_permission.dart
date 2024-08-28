enum FormDynamicPermission {
  /// No permission from any platfom
  ///
  none,

  /// Only pemrission from mobile
  ///
  mobile,

  /// Only pemrission from web
  ///
  web,

  /// Only pemrission from both [mobile] and [web]
  ///
  both,
  ;

  const FormDynamicPermission();

  String get title {
    return switch (this) {
      FormDynamicPermission.none => "None",
      FormDynamicPermission.mobile => "Only Mobile",
      FormDynamicPermission.web => "Only Web",
      FormDynamicPermission.both => "Web and Mobile",
    };
  }
}
