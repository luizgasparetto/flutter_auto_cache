import '../../../../../../core/core.dart';
import '../../../entities/cache_entity.dart';
import '../../../exceptions/invalidation_methods_exceptions.dart';
import '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  @override
  Either<AutoCacheManagerException, Unit> validate<T extends Object>(
    CacheEntity<T> cache,
  ) {
    final isExpired = cache.endAt.isBefore(DateTime.now());

    if (isExpired) {
      return left(ExpiredTTLException());
    }

    return right(unit);
  }
}
