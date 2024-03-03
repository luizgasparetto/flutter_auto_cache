import '../../../../core/core.dart';

class CacheNotExistsException extends AutoCacheManagerException {
  CacheNotExistsException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'cache-not-exists');
}

class NotInitializedAutoCacheManagerException implements AutoCacheManagerException {
  @override
  String get code => 'not_initialized_auto_cache_manager';

  @override
  String get message => 'Auto cache manager is not initialized yet';

  @override
  StackTrace get stackTrace => StackTrace.current;
}
