import '../../../errors/auto_cache_error.dart';

/// Exception thrown when there is an error calculating the cache size.
///
/// This exception indicates a failure during the calculation of the total size
/// of the cache. It provides details about the error encountered during this
/// operation.
final class CalculateCacheSizeException extends AutoCacheException {
  CalculateCacheSizeException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'calculate_cache_size');
}
