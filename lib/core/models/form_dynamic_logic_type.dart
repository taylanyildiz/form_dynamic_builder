enum FormDynamicLogicType {
  /// And type [&&]
  and,

  /// And type [||]
  or,
  ;

  /// Title of [type]
  String get title => switch (this) {
        FormDynamicLogicType.and => "And",
        FormDynamicLogicType.or => "Or",
      };
}
