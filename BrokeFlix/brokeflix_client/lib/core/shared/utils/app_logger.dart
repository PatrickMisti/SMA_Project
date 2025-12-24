
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class AppLogger {
  static Level _level = Level.INFO;
  static config({Level level = Level.INFO}) {
    _level = level;
    Logger.root.level = _level;
    Logger.root.onRecord.listen((record) {
      debugPrint('[${record.level.name}][${record.loggerName}]: ${record.time}: ${record.message}');
    });
  }

  static Logger getLogger(String name) {
    return Logger(name);
  }
}