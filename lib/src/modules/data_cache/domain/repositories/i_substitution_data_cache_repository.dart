part of 'i_data_cache_repository.dart';

abstract interface class ISubstitutionDataCacheRepository {
  /// Retrieves all keys associated with a specific storage type.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a list of strings representing the cache keys on success.
  Either<AutoCacheException, List<String>> getKeys();

  /// Retrieves all cached entities.
  ///
  /// This method returns a comprehensive list of all entities currently stored in the cache. The result is
  /// wrapped in an [Either] which contains an [AutoCacheException] in case of a failure, or a list of [DataCacheEntity] in case
  /// of success. This allows for safe error handling and ensures type safety.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a nullable [DataCacheEntity] on success.
  Either<AutoCacheException, List<DataCacheEntity?>> getAll();

  /// Attempts to accommodate the given data cache entity.
  ///
  /// This method checks if the cache can accommodate the new data. If `recursive` is true,
  /// it will recursively attempt to make space for the new data.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a boolean indicating success.
  AsyncEither<AutoCacheException, bool> accomodateCache<T extends Object>(DataCacheEntity<T> cache, {bool recursive = false});
}
