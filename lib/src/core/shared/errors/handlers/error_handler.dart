import '../../services/log_service/implementations/log_service.dart';
import '../auto_cache_error.dart';

final class ErrorHandler {
  static AutoCacheError handle(AutoCacheError error) {
    LogService.instance.logError(error);
    return error;
  }
}
