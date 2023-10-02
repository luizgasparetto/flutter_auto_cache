import '../../../../../core/core.dart';

import '../../entities/cache_entity.dart';
import '../../enums/invalidation_types.dart';

import 'strategies/ttl_invalidation_strategy.dart';

class InvalidationCacheContext {
  Either<AutoCacheManagerException, Unit> execute<T>(CacheEntity<T> cache) {
    return switch (cache.invalidationType) {
      InvalidationTypes.refresh => TTLInvalidationStrategy.instance.validate(cache),
      InvalidationTypes.ttl => TTLInvalidationStrategy.instance.validate(cache),
    };
  }
}
