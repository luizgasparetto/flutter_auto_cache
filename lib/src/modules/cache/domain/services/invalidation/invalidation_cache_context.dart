import '../../../../../core/core.dart';

import '../../entities/cache_entity.dart';
import 'methods/implementations/ttl_invalidation_cache_method.dart';

class InvalidationCacheContext {
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache) {
    // return switch (cache.invalidationType) {
    //   InvalidationType.refresh => TTLInvalidationStrategy.instance.validate(cache),
    //   InvalidationType.ttl => TTLInvalidationStrategy.instance.validate(cache),
    // };
    return TTLInvalidationCacheMethod.I.execute(cache);
  }
}
