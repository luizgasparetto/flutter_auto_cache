part of '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  @override
  Either<AutoCacheError, InvalidationStatus> validate<T extends Object>(DataCacheEntity<T> cache) {
    final isExpired = cache.endAt.isBefore(DateTime.now());

    if (isExpired) return right(InvalidationStatus.invalid);

    return right(InvalidationStatus.valid);
  }
}
