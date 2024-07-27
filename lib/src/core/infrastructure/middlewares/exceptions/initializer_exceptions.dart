import '../../../shared/errors/auto_cache_error.dart';

class NotInitializedAutoCacheException extends AutoCacheException {
  NotInitializedAutoCacheException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'not_initialized_auto_cache');
}
