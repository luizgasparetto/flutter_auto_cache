import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';

mixin IDataCacheDatasource on IQueryDataCacheDatasource, ICommandDataCacheDatasource {}

/// Defines the contract for a command data cache data source, providing methods to persist,
/// delete, and clear cached entities.
///
/// This interface ensures a standardized way to interact with cache storage, allowing for
/// the secure handling of key-value pairs within a data transfer object (DTO). Each implementing
/// class is expected to handle encryption, data integrity, and storage.
abstract interface class ICommandDataCacheDatasource {
  /// Persists a data entity in the cache based on the details provided within a data transfer object (DTO).
  ///
  /// This asynchronous operation saves an entity to the cache using a key-value pair encapsulated within
  /// the provided DTO. It ensures data integrity and type safety during the save operation.
  ///
  /// Parameters:
  ///   - [dto]: A `SaveCacheDTO<T>` object containing the key under which the entity is stored and the entity itself.
  ///
  /// Returns:
  ///   - A `Future<void>` that completes when the operation has successfully persisted the entity.
  Future<void> save<T extends Object>(WriteCacheDTO<T> dto);

  Future<void> update<T extends Object>(UpdateCacheDTO<T> dto);

  /// Deletes a specific cache entry identified by its key.
  ///
  /// This asynchronous operation removes a cache entry corresponding to the specified key. It is typically used
  /// to manage cache size or remove outdated or unnecessary data.
  ///
  /// Parameters:
  ///   - [key]: A `String` representing the unique key associated with the cache entry to be deleted.
  ///
  /// Returns:
  ///   - A `Future<void>` that completes when the entry has been successfully removed.
  Future<void> delete(String key);

  /// Clears all entries from the cache.
  ///
  /// This comprehensive asynchronous operation is used to completely empty the cache, effectively resetting it.
  /// It is useful during scenarios such as application resets, user logout, or when transitioning between major updates.
  ///
  /// Returns:
  ///   - A `Future<void>` that completes when the cache has been entirely cleared.
  Future<void> clear();
}

/// Defines the contract for querying data from the cache, providing methods to retrieve
/// specific cached entities and obtain a list of all cached keys.
///
/// This interface establishes standardized methods to safely and reliably access cached entities
/// while providing an overview of the available keys for various management and debugging scenarios.
abstract interface class IQueryDataCacheDatasource {
  /// Retrieves a cached entity associated with a specific key.
  ///
  /// The method attempts to find an entity in the cache that matches the specified key. If no such entity exists,
  /// the method returns `null`. This operation is type-safe, ensuring that the retrieved entity, if present,
  /// is of the expected data type.
  ///
  /// Parameters:
  ///   - [key]: A `String` representing the unique key associated with the cache entry.
  ///
  /// Returns:
  ///   - A `DataCacheEntity<T>?`, which is the cached entity if found, or `null` if no such entity exists.
  DataCacheEntity<T>? get<T extends Object>(String key);

  DataCacheEntity<T>? getList<T extends Object, DataType extends Object>(String key);

  Future<bool> accomodateCache<T extends Object>(DataCacheEntity<T> dataCache);

  /// Retrieves a comprehensive list of all keys currently stored in the cache.
  ///
  /// This method provides an overview of the cache's contents by listing all the keys. It can be useful for
  /// debugging purposes or when performing bulk operations on the cache.
  ///
  /// Returns:
  ///   - A `List<String>` containing all the keys within the cache.
  List<String> getKeys();
}
