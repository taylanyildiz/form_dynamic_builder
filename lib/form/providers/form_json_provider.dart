import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import 'form_field_dependency_provider.dart';
import 'form_field_provider.dart';
import 'form_notifier_provider.dart';

/// Form json provider
///
final formJsonProvider = Provider.autoDispose<String>((ref) {
  FormDynamic form = ref.read(formNotifierProvider);
  form = form.copyWith(
    fields: form.fields.asMap().entries.map((e) => ref.read(formFieldProvider(e.value.id)).copyWith(seq: e.key)).toList(),
    dependencies: form.fields.map((e) => ref.read(formFieldDependencyProvider(e.id))).toList(),
  );
  final json = form.toJson();
  return const JsonEncoder.withIndent('  ').convert(json);
});
