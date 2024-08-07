part of '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  @override
  Either<AutoCacheError, InvalidationStatus> validate<T extends Object>(CacheEntity cache) {
    final isExpired = cache.metadata.endAt.isBefore(DateTime.now());
    final status = isExpired ? InvalidationStatus.invalid : InvalidationStatus.valid;

    return right(status);
  }
}
