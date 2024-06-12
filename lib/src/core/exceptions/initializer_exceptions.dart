import '../core.dart';

class NotInitializedAutoCacheException extends AutoCacheManagerException {
  NotInitializedAutoCacheException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'not_initialized_auto_cache');
}
