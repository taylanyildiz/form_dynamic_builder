import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import '../notifiers/notifiers.dart';

/// Form field operation
///
/// argument represent specified field unqiue id
final formFieldOperationProvider = AutoDisposeNotifierProviderFamily<FormFieldOperationNotifier, FormFieldOperationLink, String>(
  FormFieldOperationNotifier.new,
);
