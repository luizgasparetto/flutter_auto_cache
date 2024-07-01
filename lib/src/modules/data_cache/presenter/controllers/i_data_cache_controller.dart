import 'dart:async';

/// A mixin that combines the functionalities of querying and commanding a data cache.
///
/// Implements the base data cache operations for querying and manipulating cached data.
/// This mixin provides a unified interface for fetching, saving, deleting, and clearing cached data.
mixin IDataCacheController on _IQueryDataCacheController, _ICommandDataCacheController {}

/// An abstract class that defines query operations for a data cache.
///
/// Provides methods to retrieve cached objects and lists of cached objects based on a unique key.
/// Implementations of this interface should handle data retrieval and error management.
abstract interface class _IQueryDataCacheController {
  /// Fetches a cached object of type [T] corresponding to the specified [key].
  ///
  /// - [key]: A unique identifier associated with the desired cached object.
  ///
  /// Returns the cached object of type [T] if found, or `null` if not present.
  ///
  /// Throws an error if data retrieval fails.
  T? get<T extends Object>({required String key});

  /// Retrieves a list of cached objects of type [T] associated with the specified [key].
  ///
  /// - [key]: A unique identifier linked to the desired cached list.
  ///
  /// Returns a list of cached objects if found, or `null` if not present.
  ///
  /// Throws an error if data retrieval encounters an issue.
  List<T>? getList<T extends Object>({required String key});
}

/// An abstract class that defines command operations for a data cache.
///
/// Provides methods to save, delete, and clear cached data based on a unique key.
/// Implementations of this interface should handle data manipulation and error management.
abstract interface class _ICommandDataCacheController {
  /// Saves an object of type [T] into the cache under the provided [key].
  ///
  /// - [key]: The unique identifier to associate with the cached object.
  /// - [data]: The object to be saved in the cache.
  ///
  /// Throws an exception if the cache save operation encounters an error.
  Future<void> save<T extends Object>({required String key, required T data});

  /// Deletes a specific cached entry identified by the given [key].
  ///
  /// - [key]: The unique identifier associated with the cache entry to be deleted.
  ///
  /// Throws an exception if the cache deletion operation encounters an error.
  Future<void> delete({required String key});

  /// Clears all cache entries stored within the cache system.
  ///
  /// Throws an exception if the cache clearing operation encounters an error.
  Future<void> clear();
}
