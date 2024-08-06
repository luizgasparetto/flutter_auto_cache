import 'dart:async';

import '../../../../core/infrastructure/protocols/cache_response.dart';
import '../../domain/value_objects/data_cache_options.dart';

/// An interface that defines methods for querying and commanding a data cache.
///
/// This interface provides the base operations for querying and manipulating
/// cached data, offering a unified approach for fetching, saving, deleting, and
/// clearing cached data.
abstract class IBaseDataCacheController {
  /// Fetches a cached object of type [T] corresponding to the specified [key].
  ///
  /// - [key]: A unique identifier associated with the desired cached object.
  ///
  /// Returns the cached object of type [T] if found, or `null` if not present.
  ///
  /// Throws an exception if data retrieval fails.
  Future<CacheResponse<T?>> get<T extends Object>({required String key});

  /// Retrieves a list of cached objects of type [T] associated with the specified [key].
  ///
  /// - [key]: A unique identifier linked to the desired cached list.
  ///
  /// Returns a list of cached objects if found, or `null` if not present.
  ///
  /// Throws an exception if data retrieval encounters an issue.
  Future<CacheResponse<List<T>?>> getList<T extends Object>({required String key});

  /// Saves an object of type [T] into the cache under the provided [key].
  ///
  /// - [key]: The unique identifier to associate with the cached object.
  /// - [data]: The object to be saved in the cache.
  ///
  /// Throws an exception if the cache save operation encounters an error.
  Future<void> save<T extends Object>({required String key, required T data, DataCacheOptions? options});

  /// Deletes a specific cached entry identified by the given [key].
  ///
  /// - [key]: The unique identifier associated with the cache entry to b|e deleted.
  ///
  /// Throws an exception if the cache deletion operation encounters an error.
  Future<void> delete({required String key});

  /// Clears all cache entries stored within the cache system.
  ///
  /// Throws an exception if the cache clearing operation encounters an error.
  Future<void> clear();
}
