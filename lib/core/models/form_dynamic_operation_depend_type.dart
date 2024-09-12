enum FormDynamicOperationDependType {
  /// Field type
  ///
  field,

  /// Handle type
  ///
  handle,
  ;

  String get title => switch (this) {
        FormDynamicOperationDependType.field => "Field",
        FormDynamicOperationDependType.handle => "Value",
      };
}
