import '../../domain/entities/data_cache_entity.dart';

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
  Future<void> write<T extends Object>(DataCacheEntity<T> cache);

  /// Increments the access count of a cached data entity.
  ///
  /// This asynchronous operation increases the usage count of a specific cache entity. It is typically used
  /// for tracking the frequency of access to cached items, which can inform cache eviction policies and
  /// help optimize cache management strategies.
  Future<void> updateUsageCount<T extends Object>(DataCacheEntity<T> cache);

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
