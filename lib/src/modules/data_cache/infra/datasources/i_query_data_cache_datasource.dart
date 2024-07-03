import '../../domain/entities/data_cache_entity.dart';

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
