import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

import '../../entities/data_cache_entity.dart';
import '../../enums/invalidation_status.dart';

part 'strategies/ttl_invalidation_cache_strategy.dart';

/// This abstract interface defines the contract for cache invalidation strategies.
/// Implementations of this interface should provide a method to validate cache entities.
abstract interface class InvalidationCacheStrategy {
  /// Validates the given [cache] entity of a generic type [T].
  ///
  /// This method takes a [DataCacheEntity] and returns an [Either] type, indicating either
  /// a failure of type [AutoCacheFailure] or success as a [Unit]. The validation logic
  /// should determine whether the cache entity is still valid or needs invalidation.
  Either<AutoCacheError, InvalidationStatus> validate<T extends Object>(DataCacheEntity<T> cache);
}
