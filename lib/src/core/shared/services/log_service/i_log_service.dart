import '../../errors/auto_cache_error.dart';

abstract interface class ILogService {
  void logException(AutoCacheException exception);
}
