import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/models/models.dart';
import '/form/notifiers/notifiers.dart';

/// Form notifier provider
///
/// to watch [FormDynamic]
final formNotifierProvider = NotifierProvider<FormNotifier, FormDynamic>(
  FormNotifier.new,
);
