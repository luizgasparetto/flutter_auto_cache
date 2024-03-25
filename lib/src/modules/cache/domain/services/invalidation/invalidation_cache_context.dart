import '../../../../../core/core.dart';

import '../../entities/cache_entity.dart';
import 'invalidation_cache_strategy.dart';
import 'strategies/ttl_invalidation_cache_strategy.dart';

abstract interface class IInvalidationCacheContext {
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache);
}

final class InvalidationCacheContext implements IInvalidationCacheContext {
  final CacheConfig config;

  const InvalidationCacheContext(this.config);

  @override
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache) {
    final strategy = _getInvalidationCacheStrategy();
    return strategy.validate<T>(cache);
  }

  InvalidationCacheStrategy _getInvalidationCacheStrategy() {
    return switch (config.invalidationType) {
      _ => TTLInvalidationCacheStrategy(config),
    };
  }
}
