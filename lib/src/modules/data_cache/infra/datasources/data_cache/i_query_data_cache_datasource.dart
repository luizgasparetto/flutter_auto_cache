import '../../../domain/entities/data_cache_entity.dart';

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

  /// Retrieves a comprehensive list of all keys currently stored in the cache.
  ///
  /// This method provides an overview of the cache's contents by listing all the keys. It can be useful for
  /// debugging purposes or when performing bulk operations on the cache.
  ///
  /// Returns:
  ///   - A `List<String>` containing all the keys within the cache.
  List<String> getKeys();
}
