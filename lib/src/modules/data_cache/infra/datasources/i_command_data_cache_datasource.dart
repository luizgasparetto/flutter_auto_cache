import '../../domain/dtos/write_cache_dto.dart';

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

  Future<void> update<T extends Object>(WriteCacheDTO<T> dto);

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
