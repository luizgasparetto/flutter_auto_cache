import '../../../../../core/core.dart';
import '../../entities/data_cache_entity.dart';
import '../../enums/invalidation_types.dart';
import 'invalidation_cache_strategy.dart';
import 'strategies/ttl_invalidation_cache_strategy.dart';

/// This abstract interface defines the contract for cache invalidation contexts.
/// Implementations of this interface should provide a strategy for invalidating caches.
abstract interface class IInvalidationCacheService {
  /// Executes the cache invalidation logic.
  ///
  /// This method takes a [DataCacheEntity] of a generic type [T] and returns an [Either] type,
  /// indicating either a failure of type [AutoCacheFailure] or success as a [Unit].
  Either<AutoCacheFailure, Unit> execute<T extends Object>(DataCacheEntity<T> cache);
}

/// This class provides an implementation of [IInvalidationCacheService].
/// It uses a [CacheConfig] to determine the appropriate invalidation strategy.
final class InvalidationCacheService implements IInvalidationCacheService {
  final CacheConfiguration configuration;

  /// Constructs an [InvalidationCacheService] with the given [config].
  const InvalidationCacheService(this.configuration);

  /// Executes the cache invalidation strategy based on the provided [cache].
  ///
  /// The method utilizes the configured invalidation strategy to validate the cache entity.
  @override
  Either<AutoCacheFailure, Unit> execute<T extends Object>(DataCacheEntity<T> cache) {
    return invalidationCacheStrategy.validate<T>(cache);
  }

  /// Determines the cache invalidation strategy based on the configuration.
  InvalidationCacheStrategy get invalidationCacheStrategy {
    return switch (configuration.dataCacheOptions.invalidationType) {
      InvalidationTypes.ttl => TTLInvalidationCacheStrategy(),
    };
  }
}
