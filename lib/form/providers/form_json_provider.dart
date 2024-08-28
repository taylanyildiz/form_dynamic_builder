import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'form_notifier_provider.dart';

/// Form json provider
///
final formJsonProvider = Provider<String>((ref) {
  final form = ref.read(formNotifierProvider);
  final json = form.toJson();
  return const JsonEncoder.withIndent('  ').convert(json);
});
