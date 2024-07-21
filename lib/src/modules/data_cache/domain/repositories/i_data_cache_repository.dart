import '../../../../core/errors/auto_cache_error.dart';
import '../../../../core/functional/either.dart';

import '../dtos/key_cache_dto.dart';
import '../dtos/update_cache_dto.dart';
import '../dtos/write_cache_dto.dart';

import '../entities/data_cache_entity.dart';

part 'i_substitution_data_cache_repository.dart';

/// An interface defining the repository for managing cache operations.
///
/// This repository provides methods for retrieving, saving, updating, deleting, and clearing
/// cached data while handling potential exceptions.
abstract interface class IDataCacheRepository {
  /// Retrieves a cached entity of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter specifies the criteria to identify and fetch the cached entity.
  ///
  /// - Parameter [dto]: An object of type [KeyCacheDTO] that contains the criteria to locate the cache.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a nullable [DataCacheEntity] of type [T] on success.
  Either<AutoCacheException, DataCacheEntity<T>?> get<T extends Object>(KeyCacheDTO dto);

  /// Retrieves a list of cached entities of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter specifies the criteria to identify and fetch the cached entities.
  ///
  /// - Parameter [dto]: An object of type [KeyCacheDTO] that contains the criteria to locate the cache.
  ///
  /// Returns:
  /// - An [Either] containing an [AutoCacheException] on failure, or a nullable list of [DataCacheEntity] of type [T] on success.
  Either<AutoCacheException, DataCacheEntity<T>?> getList<T extends Object, DataType extends Object>(KeyCacheDTO dto);

  // /// Retrieves all keys associated with a specific storage type.
  // ///
  // /// Returns:
  // /// - An [Either] containing an [AutoCacheException] on failure, or a list of strings representing the cache keys on success.
  // Either<AutoCacheException, List<String>> getKeys();

  // /// Attempts to accommodate the given data cache entity.
  // ///
  // /// This method checks if the cache can accommodate the new data. If `recursive` is true,
  // /// it will recursively attempt to make space for the new data.
  // ///
  // /// - Parameter [dataCache]: The data cache entity to be accommodated.
  // /// - Parameter [recursive]: Whether to attempt accommodating recursively. Default is false.
  // ///
  // /// Returns:
  // /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a boolean indicating success.
  // AsyncEither<AutoCacheException, bool> accomodateCache<T extends Object>(DataCacheEntity<T> cache, {bool recursive = false});

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
  /// This method updates the cached data with the new values provided in the [dto].
  ///
  /// - Parameter [dto]: An object of type [UpdateCacheDTO] containing the data and metadata to update the cache.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> update<T extends Object>(UpdateCacheDTO<T> dto);

  /// Deletes a cached data entry based on the criteria in [dto].
  ///
  /// The [dto] parameter provides the necessary information to identify the cached data to delete.
  ///
  /// - Parameter [dto]: An object of type [KeyCacheDTO] containing the criteria to delete the cache.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> delete(KeyCacheDTO dto);

  /// Clears all cached data.
  ///
  /// This method clears all cached data regardless of specific criteria.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> clear();
}
