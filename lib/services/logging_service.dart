import 'package:logger/logger.dart';

class LogService {
  Logger log = Logger();
  static const _DEBUG = true;

  void d(String message) {
    if (_DEBUG) {
      log.d(message);
    } else {
      return;
    }
  }

  void e(String message) {
    if (_DEBUG) {
      log.e(message);
    } else {
      return;
    }
  }

  void i(String message) {
    if (_DEBUG) {
      log.i(message);
    } else {
      return;
    }
  }

  void l(Level level, String message) {
    if (_DEBUG) {
      log.log(level, message);
    } else {
      return;
    }
  }

  void v(String message) {
    if (_DEBUG) {
      log.v(message);
    } else {
      return;
    }
  }

  void w(String message) {
    if (_DEBUG) {
      log.w(message);
    } else {
      return;
    }
  }

  void wtf(String message) {
    if (_DEBUG) {
      log.wtf(message);
    } else {
      return;
    }
  }
}
