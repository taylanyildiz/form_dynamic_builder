import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/models/types.dart';

/// Form dynamic field preview provider
/// gives [FormDynamicFieldLocation]
///
final formFieldPreviewProvider = StateProvider<FormDynamicFieldLocation?>((_) => null);
