import '../../../../../../core/core.dart';
import '../../../entities/cache_entity.dart';
import '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  final CacheConfig config;

  const TTLInvalidationCacheStrategy(this.config);

  @override
  Either<AutoCacheManagerException, Unit> validate<T extends Object>(CacheEntity<T> cache) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
