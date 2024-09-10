import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/providers/providers.dart';
import '/core/models/models.dart';

/// Form dynamic field provider
///
///
final formFieldProvider = StateProvider.family<FormDynamicField, String>((ref, arg) {
  final fields = ref.read(formNotifierProvider.select((e) => e.fields));
  FormDynamicField field = fields.firstWhere((e) => e.id == arg);
  return field;
});
