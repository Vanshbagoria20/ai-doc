import 'package:logger/logger.dart';

class applogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 100, // Maximum length of each log line
      colors: true, // Enable colored logs
      printEmojis: true, // Include emojis in logs
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // Show timestamps
    ),
  );

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, {error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void verbose(String message) {
    _logger.t(message);
  }
}

