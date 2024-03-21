import '../../../../../../core/core.dart';
import '../../../entities/cache_entity.dart';
import '../../../enums/invalidation_type.dart';
import 'implementations/ttl_invalidation_cache_method.dart';

class InvalidationCacheMethodContext {
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache) {
    return switch (cache.invalidationType) {
      InvalidationType.refresh => TTLInvalidationCacheMethod.I.execute(cache),
      InvalidationType.ttl => TTLInvalidationCacheMethod.I.execute(cache),
    };
  }
}
