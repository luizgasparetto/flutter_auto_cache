import '../../../../../core/core.dart';
import '../../../../../core/functional/either.dart';

import '../../entities/data_cache_entity.dart';
import '../../enums/invalidation/invalidation_status.dart';
import '../../enums/invalidation/invalidation_types.dart';

import 'invalidation_cache_strategy.dart';

/// This abstract interface defines the contract for cache invalidation contexts.
/// Implementations of this interface should provide a strategy for invalidating caches.
abstract interface class IInvalidationCacheService {
  /// Executes the cache invalidation logic.
  ///
  /// This method takes a [DataCacheEntity] of a generic type [T] and returns an [Either] type,
  /// indicating either a failure of type [AutoCacheFailure] or success as a [Unit].
  Either<AutoCacheFailure, bool> validate<T extends Object>(DataCacheEntity<T> cache);
}

final class InvalidationCacheService implements IInvalidationCacheService {
  final CacheConfiguration configuration;

  const InvalidationCacheService(this.configuration);

  @override
  Either<AutoCacheFailure, bool> validate<T extends Object>(DataCacheEntity<T> cache) {
    return invalidationCacheStrategy.validate<T>(cache).mapRight((status) => status == InvalidationStatus.valid);
  }

  InvalidationCacheStrategy get invalidationCacheStrategy {
    return switch (configuration.dataCacheOptions.invalidationType) {
      InvalidationTypes.ttl => TTLInvalidationCacheStrategy(),
    };
  }
}
