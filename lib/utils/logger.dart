import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: false,
  ),
);

void initLoggerListeners() {
  Logger.addLogListener(_loggerListener);
}

void _loggerListener(LogEvent event) {
  if (event.level.index < Level.error.index) {
    return;
  }
  FirebaseCrashlytics.instance.recordError(
    event.message,
    event.stackTrace,
    reason: event.error,
    information: [
      'Time: ${event.time}',
    ],
    fatal: event.level == Level.fatal,
  );
}

void logDebug(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  logger.d(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );
}

void logError(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  logger.e(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );
}
