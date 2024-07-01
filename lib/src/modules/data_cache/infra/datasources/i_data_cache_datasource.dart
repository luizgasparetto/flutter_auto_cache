import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';

/// A mixin that combines both query and command data cache data source functionalities.
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
  Future<void> save<T extends Object>(WriteCacheDTO<T> dto);

  /// Updates a cached data entity based on the details provided within a data transfer object (DTO).
  ///
  /// This asynchronous operation updates an entity in the cache using a key-value pair encapsulated within
  /// the provided DTO. It ensures data integrity and type safety during the update operation.
  Future<void> update<T extends Object>(UpdateCacheDTO<T> dto);

  /// Deletes a specific cache entry identified by its key.
  ///
  /// This asynchronous operation removes a cache entry corresponding to the specified key. It is typically used
  /// to manage cache size or remove outdated or unnecessary data.
  Future<void> delete(String key);

  /// Clears all entries from the cache.
  ///
  /// This comprehensive asynchronous operation is used to completely empty the cache, effectively resetting it.
  /// It is useful during scenarios such as application resets, user logout, or when transitioning between major updates.
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
  DataCacheEntity<T>? get<T extends Object>(String key);

  /// Retrieves a list of cached entities associated with a specific key.
  ///
  /// The method attempts to find entities in the cache that match the specified key. If no such entities exist,
  /// the method returns `null`. This operation is type-safe, ensuring that the retrieved entities, if present,
  /// are of the expected data type.
  DataCacheEntity<T>? getList<T extends Object, DataType extends Object>(String key);

  /// Attempts to accommodate a data cache entity in the cache.
  ///
  /// This asynchronous operation checks if the cache can accommodate the provided data cache entity. It handles
  /// necessary adjustments to ensure the entity fits within the cache constraints.
  Future<bool> accomodateCache<T extends Object>(DataCacheEntity<T> dataCache);

  /// Retrieves a comprehensive list of all keys currently stored in the cache.
  ///
  /// This method provides an overview of the cache's contents by listing all the keys. It can be useful for
  /// debugging purposes or when performing bulk operations on the cache.
  List<String> getKeys();
}
