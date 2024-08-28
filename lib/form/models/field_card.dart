import 'package:equatable/equatable.dart';
import '/core/models/models.dart';

class FieldCard with EquatableMixin {
  /// Field object
  final FormDynamicField field;

  /// Card is expanded
  /// default [false]
  final bool expanded;

  FieldCard({
    required this.field,
    this.expanded = false,
  });

  FieldCard copyWith({
    FormDynamicField? field,
    bool? expanded,
  }) =>
      FieldCard(
        field: field ?? this.field,
        expanded: expanded ?? this.expanded,
      );

  @override
  List<Object?> get props => [field, expanded];
}
