import '../../domain/entities/cache_entity.dart';

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
  ///   - A `CacheEntity<T>?`, which is the cached entity if found, or `null` if no such entity exists.
  CacheEntity<T>? get<T extends Object>(String key);

  /// Retrieves a comprehensive list of all keys currently stored in the cache.
  ///
  /// This method provides an overview of the cache's contents by listing all the keys. It can be useful for
  /// debugging purposes or when performing bulk operations on the cache.
  ///
  /// Returns:
  ///   - A `List<String>` containing all the keys within the cache.
  List<String> getKeys();
}
