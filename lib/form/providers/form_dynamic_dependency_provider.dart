import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/models.dart';
import '../notifiers/notifiers.dart';

/// Form field dependency
final formFieldDependencyProvider = AutoDisposeNotifierProviderFamily<FormFieldDependencyNotifier, FormFieldDependencyLink, String>(
  FormFieldDependencyNotifier.new,
);
