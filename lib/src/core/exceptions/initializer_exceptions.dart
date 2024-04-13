import '../core.dart';

class NotInitializedAutoCacheManagerException extends AutoCacheManagerException {
  NotInitializedAutoCacheManagerException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'not_initialized_auto_cache_manager');
}
