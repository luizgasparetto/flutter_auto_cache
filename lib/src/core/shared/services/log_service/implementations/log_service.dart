import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../errors/auto_cache_error.dart';
import '../i_log_service.dart';
import 'factories/error_method_details_factory.dart';

final class LogService implements ILogService {
  LogService._();

  static final LogService _instance = LogService._();

  static LogService get instance => _instance;

  @override
  void logError(AutoCacheError error) {
    final methodDetails = ErrorMethodDetailsFactory.create();

    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      debugPrint('\x1B[31m[FlutterAutoCache] Message: ${error.message}\x1B[0m');
      debugPrint('\x1B[31m[FlutterAutoCache] Error Code: ${error.code}\x1B[0m');
      debugPrint('\x1B[31m[FlutterAutoCache] Method Called: ${methodDetails.method}\x1B[0m');
      debugPrint('\x1B[31m[FlutterAutoCache] Error Line: ${methodDetails.errorLine}\x1B[0m');
    }
  }
}
