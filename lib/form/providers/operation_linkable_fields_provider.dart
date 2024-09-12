import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import '/form/providers/providers.dart';

/// Linkable fields
///
/// of type not [FormDynamicFieldType.header] and field itself.
final operationLinkableFieldsProvider = Provider.family<List<FormDynamicField>, String>((ref, arg) {
  List<FormDynamicField> fields = ref.watch(formNotifierProvider.select((e) => e.fields));
  fields = fields.map((e) => ref.watch(formFieldProvider(e.id))).toList();
  fields = fields.where((e) => e.id != arg && e.type == FormDynamicFieldType.text).toList();
  return fields;
});
