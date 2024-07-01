import '../../../core.dart';

class CalculateCacheSizeException extends AutoCacheException {
  const CalculateCacheSizeException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'calculate_cache_size');
}
