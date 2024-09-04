enum FormDynamicDependencyType {
  /// Field equal
  ///
  equal,

  /// Field not equal
  ///
  notEqual,

  /// Field greated
  ///
  great,

  /// Field less
  ///
  less,

  /// Field empty
  ///
  empty,

  /// Field not empty
  ///
  notEMpty,

  /// Enabled
  ///
  enabled,

  /// contains
  ///
  /// when field multiseletable select or checkbox
  contain,
  ;

  String get title => switch (this) {
        FormDynamicDependencyType.equal => "Equal",
        FormDynamicDependencyType.notEqual => "Not Equal",
        FormDynamicDependencyType.great => "Great",
        FormDynamicDependencyType.less => "Less",
        FormDynamicDependencyType.empty => "Empty",
        FormDynamicDependencyType.notEMpty => "Not Empty",
        FormDynamicDependencyType.enabled => "Enabled",
        FormDynamicDependencyType.contain => "Contain",
      };
}
