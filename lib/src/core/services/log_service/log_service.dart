import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../../flutter_auto_cache.dart';

final class LogService {
  static void logException(AutoCacheException exception) {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      debugPrint('\x1B[31m[FlutterAutoCache] ${exception.code}: ${exception.message}\x1B[0m');
    }
  }
}
