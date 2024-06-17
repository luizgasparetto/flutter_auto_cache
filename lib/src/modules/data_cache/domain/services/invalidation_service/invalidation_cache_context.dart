import '../../../../../core/core.dart';
import '../../entities/cache_entity.dart';
import '../../enums/invalidation_type.dart';
import 'invalidation_cache_strategy.dart';
import 'strategies/ttl_invalidation_cache_strategy.dart';

/// This abstract interface defines the contract for cache invalidation contexts.
/// Implementations of this interface should provide a strategy for invalidating caches.
abstract interface class IInvalidationCacheContext {
  /// Executes the cache invalidation logic.
  ///
  /// This method takes a [CacheEntity] of a generic type [T] and returns an [Either] type,
  /// indicating either a failure of type [AutoCacheFailure] or success as a [Unit].
  Either<AutoCacheFailure, Unit> execute<T extends Object>(CacheEntity<T> cache);
}

/// This class provides an implementation of [IInvalidationCacheContext].
/// It uses a [CacheConfig] to determine the appropriate invalidation strategy.
final class InvalidationCacheContext implements IInvalidationCacheContext {
  final CacheConfig config;

  /// Constructs an [InvalidationCacheContext] with the given [config].
  const InvalidationCacheContext(this.config);

  /// Executes the cache invalidation strategy based on the provided [cache].
  ///
  /// The method utilizes the configured invalidation strategy to validate the cache entity.
  @override
  Either<AutoCacheFailure, Unit> execute<T extends Object>(CacheEntity<T> cache) {
    return invalidationCacheStrategy.validate<T>(cache);
  }

  /// Determines the cache invalidation strategy based on the configuration.
  InvalidationCacheStrategy get invalidationCacheStrategy {
    return switch (config.invalidationType) {
      InvalidationType.ttl => TTLInvalidationCacheStrategy(),
      _ => TTLInvalidationCacheStrategy(),
    };
  }
}
