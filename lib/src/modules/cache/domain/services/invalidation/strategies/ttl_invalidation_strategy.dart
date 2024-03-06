import '../../../../../../core/core.dart';

import '../../../entities/cache_entity.dart';
import '../invalidation_cache_strategy.dart';

class TTLInvalidationStrategy implements InvalidationCacheStrategy {
  const TTLInvalidationStrategy._create();

  static const instance = TTLInvalidationStrategy._create();

  DateTime get maxTime => DateTime.now().add(const Duration(days: 3));

  @override
  Either<AutoCacheManagerException, Unit> validate<T extends Object>(CacheEntity<T> cache) {
    final isCacheAfterMaxTime = cache.createdAt.isAfter(maxTime);

    if (isCacheAfterMaxTime) {}

    return right(unit);
  }
}
