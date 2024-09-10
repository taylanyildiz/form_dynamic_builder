import 'package:equatable/equatable.dart';
import '../utils/functions.dart';

class FormDynamicFieldOption with EquatableMixin {
  final String id;
  final String value;

  FormDynamicFieldOption({
    String? id,
    String? value,
  })  : id = id ?? uuid,
        value = value ?? "";

  FormDynamicFieldOption copyWith({
    String? id,
    String? value,
  }) {
    return FormDynamicFieldOption(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return "$id -> Value: $value";
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };

  factory FormDynamicFieldOption.fromJson(Map<String, dynamic> json) {
    return FormDynamicFieldOption(
      id: json['id'],
      value: json['value'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
      ];
}
