import '../../../../../core/core.dart';

import '../../entities/cache_entity.dart';

import '../../enums/invalidation_type.dart';
import 'strategies/ttl_invalidation_strategy.dart';

class InvalidationCacheContext {
  static Either<AutoCacheManagerException, Unit> execute<T>(CacheEntity<T> cache) {
    return switch (cache.invalidationType) {
      InvalidationType.refresh => TTLInvalidationStrategy.instance.validate(cache),
      InvalidationType.ttl => TTLInvalidationStrategy.instance.validate(cache),
    };
  }
}
