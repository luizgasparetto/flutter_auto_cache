import '../../../../../../core/core.dart';

import '../../../entities/cache_entity.dart';
import '../invalidation_cache_strategy.dart';

class TTLInvalidationStrategy implements InvalidationCacheStrategy {
  DateTime get maxTime => DateTime.now().add(const Duration(days: 300));

  @override
  Either<AutoCacheManagerException, Unit> validate<T>(CacheEntity<T> cache) {
    final isCacheAfterMaxTime = cache.createdAt.isAfter(maxTime);

    if (isCacheAfterMaxTime) {}

    return right(unit);
  }
}
