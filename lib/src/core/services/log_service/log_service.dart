import 'package:flutter/foundation.dart';

final class LogService {
  static void logException(String code, String message, StackTrace stackTrace) {
    debugPrint('\x1B[31m[FlutterAutoCache] $code: $message\x1B[0m');
  }
}
