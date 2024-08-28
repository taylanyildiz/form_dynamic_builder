import 'package:logger/logger.dart';

abstract final class Log {
  /// Logger object
  static final Logger log = Logger(
    printer: PrettyPrinter(),
  );

  static void debug(String message) {
    log.d(message, time: DateTime.now());
  }

  static void info(String message) {
    log.i(message, time: DateTime.now());
  }

  static void error(dynamic message, {Error? error}) {
    log.e(message, time: DateTime.now(), error: error, stackTrace: error?.stackTrace);
  }

  static void warning(String message, [Error? error]) {
    log.w(message, error: error, stackTrace: error?.stackTrace);
  }
}
