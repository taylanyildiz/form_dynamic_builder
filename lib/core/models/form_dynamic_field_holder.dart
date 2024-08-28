import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';
import 'form_dynamic_field_type.dart';

class FormDynamicFieldHolder with EquatableMixin {
  final String id;
  final Widget icon;
  final String title;
  final FormDynamicFieldType type;

  FormDynamicFieldHolder({
    String? id,
    required this.icon,
    required this.title,
    required this.type,
  }) : id = id ?? uuid;

  FormDynamicFieldHolder copyWith({
    Widget? icon,
    String? title,
    FormDynamicFieldType? type,
  }) {
    return FormDynamicFieldHolder(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id];
}
