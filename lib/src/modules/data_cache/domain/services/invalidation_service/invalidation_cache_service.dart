import '../../../../../core/shared/configuration/cache_configuration.dart';
import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

import '../../entities/data_cache_entity.dart';
import '../../value_objects/invalidation_methods/invalidation_method.dart';
import '../../enums/invalidation_status.dart';

import 'invalidation_cache_strategy.dart';

/// This abstract interface defines the contract for cache invalidation contexts.
/// Implementations of this interface should provide a strategy for invalidating caches.
abstract interface class IInvalidationCacheService {
  /// Executes the cache invalidation logic.
  ///
  /// This method takes a [DataCacheEntity] of a generic type [T] and returns an [Either] type,
  /// indicating either a failure of type [AutoCacheError] or success as a [Unit].
  Either<AutoCacheError, bool> validate<T extends Object>(DataCacheEntity<T> cache);
}

final class InvalidationCacheService implements IInvalidationCacheService {
  final CacheConfiguration configuration;

  const InvalidationCacheService(this.configuration);

  @override
  Either<AutoCacheError, bool> validate<T extends Object>(DataCacheEntity<T> cache) {
    return invalidationCacheStrategy.validate<T>(cache).mapRight((status) => status == InvalidationStatus.valid);
  }

  InvalidationCacheStrategy get invalidationCacheStrategy {
    return switch (configuration.dataCacheOptions.invalidationMethod) {
      TTLInvalidationMethod _ => TTLInvalidationCacheStrategy(),
    };
  }
}
