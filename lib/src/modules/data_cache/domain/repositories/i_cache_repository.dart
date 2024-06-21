import '../../../../core/core.dart';

import '../dtos/delete_cache_dto.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/write_cache_dto.dart';

import '../entities/cache_entity.dart';

/// An interface defining the repository for managing cache operations.
///
/// This repository provides methods for retrieving, saving, updating, deleting, and clearing
/// cached data while handling potential exceptions.
abstract interface class ICacheRepository {
  /// Retrieves a cached entity of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter specifies the criteria to identify and fetch the cached entity.
  ///
  /// - Parameter [dto]: An object of type [GetCacheDTO] that contains the criteria to locate the cache.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a nullable [CacheEntity] of type [T] on success.
  Either<AutoCacheException, CacheEntity<T>?> get<T extends Object>(GetCacheDTO dto);

  /// Retrieves a list of cached entities of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter specifies the criteria to identify and fetch the cached entities.
  ///
  /// - Parameter [dto]: An object of type [GetCacheDTO] that contains the criteria to locate the cache.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a nullable list of [CacheEntity] of type [T] on success.
  Either<AutoCacheException, CacheEntity<T>?> getList<T extends Object, DataType extends Object>(GetCacheDTO dto);

  /// Retrieves all keys associated with a specific storage type [storageType].
  ///
  /// - Parameter [storageType]: An enumerated value representing the desired storage type.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a list of strings representing the cache keys on success.
  Either<AutoCacheException, List<String>> getKeys();

  /// Saves a data object of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter provides the data and metadata required for caching.
  ///
  /// - Parameter [dto]: An object of type [WriteCacheDTO] containing the data and metadata to be cached.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> save<T extends Object>(WriteCacheDTO<T> dto);

  /// Updates a cached data object of type [T].
  ///
  /// This method updates the cached data with the new values.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> update<T extends Object>(WriteCacheDTO<T> dto);

  /// Deletes a cached data entry based on the criteria in [dto].
  ///
  /// The [dto] parameter provides the necessary information to identify the cached data to delete.
  ///
  /// - Parameter [dto]: An object of type [DeleteCacheDTO] containing the criteria to delete the cache.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> delete(DeleteCacheDTO dto);

  /// Clears all cached data that matches the criteria specified in [dto].
  ///
  /// The [dto] parameter provides the necessary information to identify which caches to clear.
  ///
  /// - Parameter [dto]: An object of type [ClearCacheDTO] containing the criteria to clear the caches.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> clear();
}
