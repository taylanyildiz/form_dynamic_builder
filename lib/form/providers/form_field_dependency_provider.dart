import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/models.dart';
import '../notifiers/notifiers.dart';

/// Form field dependency
///
/// argument represent specified field unqiue id
final formFieldDependencyProvider = AutoDisposeNotifierProviderFamily<FormFieldDependencyNotifier, FormFieldDependencyLink, String>(
  FormFieldDependencyNotifier.new,
);
