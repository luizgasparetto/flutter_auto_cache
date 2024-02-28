import '../../../../core/core.dart';

class CacheNotExistsException extends AutoCacheManagerException {
  CacheNotExistsException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'cache-not-exists');
}
