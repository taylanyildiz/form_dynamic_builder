import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import 'form_notifier_provider.dart';

/// Form dynamic field provider
///
///
final formFieldProvider = StateProvider.family<FormDynamicField, String>((ref, arg) {
  final fields = ref.read(formNotifierProvider.select((e) => e.fields));
  return fields.firstWhere((e) => e.id == arg);
});
