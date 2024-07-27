import '../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../core/shared/functional/either.dart';
import '../dtos/key_cache_dto.dart';

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

  /// Saves a data object of type [T] using the data transfer object [dto].
  ///
  /// The [dto] parameter provides the data and metadata required for caching.
  ///
  /// Returns:
  /// - An [AsyncEither] containing an [AutoCacheException] on failure, or a [Unit] indicating success.
  AsyncEither<AutoCacheException, Unit> write<T extends Object>(DataCacheEntity<T> cache);

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
