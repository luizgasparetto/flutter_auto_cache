import '../../../../core/core.dart';

class CacheSizeAnalyzerException extends AutoCacheManagerException {
  CacheSizeAnalyzerException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_cache_size');
}

class CalculateCacheSizeException extends AutoCacheManagerException {
  CalculateCacheSizeException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'calculate_cache_size');
}
