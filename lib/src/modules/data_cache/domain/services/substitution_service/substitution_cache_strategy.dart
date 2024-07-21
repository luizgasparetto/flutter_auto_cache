import 'dart:math';

import '../../../../../core/errors/auto_cache_error.dart';
import '../../../../../core/functional/either.dart';

import '../../dtos/key_cache_dto.dart';
import '../../entities/data_cache_entity.dart';
import '../../repositories/i_data_cache_repository.dart';

part './strategies/fifo_substitution_cache_strategy.dart';
part './strategies/random_substitution_cache_strategy.dart';
part './strategies/lru_substitution_cache_strategy.dart';

/// An sealed class for substitution cache strategies.
///
/// This class defines the contract for cache substitution strategies,
/// ensuring they implement methods for substituting cache data,
/// retrieving cache keys, and deleting data from the cache.
sealed class ISubstitutionCacheStrategy {
  final IDataCacheRepository dataRepository;
  final ISubstitutionDataCacheRepository substitutionRepository;

  const ISubstitutionCacheStrategy(this.dataRepository, this.substitutionRepository);

  /// Substitutes data in the cache.
  ///
  /// This method should be implemented by subclasses to define the strategy
  /// for substituting the given data in the cache.
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value);

  /// Retrieves a cache key.
  ///
  /// This method should be implemented by subclasses to define how a cache key
  /// is retrieved based on the substitution strategy.
  Either<AutoCacheError, String> getCacheKey();

  /// Deletes data from the cache.
  ///
  /// This method attempts to delete data from the cache using the provided key
  /// and then accommodate the new data. If accommodating the new data fails,
  /// it attempts to get a new cache key and delete data again.
  AsyncEither<AutoCacheError, Unit> deleteDataCache<T extends Object>(String key, DataCacheEntity<T> data) async {
    final response = await dataRepository.delete(KeyCacheDTO(key: key));

    return response.fold(left, (_) => _handleAccomodate<T>(key, data));
  }

  /// Handles accommodating new data in the cache.
  ///
  /// This method attempts to accommodate the new data in the cache. If it fails,
  /// it tries to get a new cache key and delete data again.
  AsyncEither<AutoCacheError, Unit> _handleAccomodate<T extends Object>(String key, DataCacheEntity<T> data) async {
    final accomodateResponse = await substitutionRepository.accomodateCache(data, recursive: true);

    if (accomodateResponse.isError) return left(accomodateResponse.error);
    if (accomodateResponse.success) return right(unit);

    final keyResponse = this.getCacheKey();

    return keyResponse.fold(left, (newKey) => deleteDataCache(newKey, data));
  }
}
