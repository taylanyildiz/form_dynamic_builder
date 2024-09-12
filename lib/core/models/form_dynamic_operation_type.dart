enum FormDynamicOperationType {
  /// Addition [+]
  addition,

  /// Decrease [-]
  decrease,

  /// Multiplication [*]
  multiplication,

  /// Division [/]
  division,
  ;

  /// Title of [type]
  String get title => switch (this) {
        FormDynamicOperationType.addition => "Add",
        FormDynamicOperationType.decrease => "Decrease",
        FormDynamicOperationType.multiplication => "Multiply",
        FormDynamicOperationType.division => "divide",
      };
}
