import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

Logger? _log;

Logger get log => _log ??= _createAppLogger();

Logger _createAppLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (record) {
      final message = _geMessage(record);
      final level = record.level;
      if (level.value >= Level.WARNING.value) {
        debugPrint(_getRedText(message));
        return;
      }
      if (level.value >= Level.INFO.value) {
        debugPrint(_getYellowText(message));
        return;
      }
      if (level.value >= Level.ALL.value) {
        debugPrint(_getGreenText(message));
        return;
      }
    },
  );
  return Logger('AppLogger');
}

String _getRedText(String text) => '\x1B[31m$text\x1B[0m';

String _getYellowText(String text) => '\x1B[33m$text\x1B[0m';

String _getGreenText(String text) => '\x1B[32m$text\x1B[0m';

String _geMessage(LogRecord record) => 'LOGGER: ${record.loggerName}\n'
    'DATE: ${record.time}\n'
    'MESSAGE: ${record.message}\n'
    'LEVEL: ${record.level.name}\n'
    'ERROR: ${record.error}\n'
    'STACKTRACE: ${record.stackTrace}';
