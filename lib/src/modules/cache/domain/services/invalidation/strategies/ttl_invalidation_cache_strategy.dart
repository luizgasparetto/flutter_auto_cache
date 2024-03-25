import '../../../../../../core/core.dart';
import '../../../entities/cache_entity.dart';
import '../../../exceptions/invalidation_methods_exceptions.dart';
import '../../../value_objects/invalidation_methods/implementations/ttl_invalidation_method.dart';
import '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  final CacheConfig config;

  const TTLInvalidationCacheStrategy(this.config);

  @override
  Either<AutoCacheManagerException, Unit> validate<T extends Object>(CacheEntity<T> cache) {
    try {
      final invalidationMethod = config.invalidationMethod as TTLInvalidationMethod;
      final maxDuration = invalidationMethod.duration;

      final createdAtWithMaxDuration = cache.createdAt.add(maxDuration);
      final isAfterNow = createdAtWithMaxDuration.isAfter(DateTime.now());

      if (isAfterNow) {
        return left(ExpiredTTLException());
      }

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        TTLInvalidationMethodException(
          code: 'ttl_invalidation_method',
          message: 'Failed to verify TTL of cache data',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
