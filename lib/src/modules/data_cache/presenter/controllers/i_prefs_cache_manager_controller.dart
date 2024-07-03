part of 'implementations/data_cache_manager_controller.dart';

/// Combines query and command cache management operations
///
/// This mixin unites the read and write cache operations defined in
/// [IQueryPrefsCacheManagerController] and [ICommandPrefsCachaManagerController].
mixin IPrefsCacheManagerController on IQueryPrefsCacheManagerController, ICommandPrefsCachaManagerController {}

/// Interface for querying cache operations.
///
/// Provides methods to retrieve cached values in different data types.
abstract interface class IQueryPrefsCacheManagerController {
  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `String?` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  Future<String?> getString({required String key});

  /// Retrieves an integer value from the cache for the given [key].
  ///
  /// Returns a `int?` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  Future<int?> getInt({required String key});

  /// Retrieves a JSON map from the cache associated with the specified [key].
  ///
  /// This method is asynchronous and returns a `Map<String, dynamic>?`.
  /// It returns the JSON map if it exists, or `null` if no data is found for the [key].
  Future<Map<String, dynamic>?> getJson({required String key});

  /// Retrieves a list of strings from the cache associated with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<List<String>?>`.
  /// If the data exists for the [key], it returns the list; otherwise,
  /// it returns `null` if no data is found.
  Future<List<String>?> getStringList({required String key});

  /// Retrieves a list of JSON maps from the cache associated with the specified [key].
  ///
  /// This method returns a `List<Map<String, dynamic>>?`.
  /// If the data exists for the [key], it returns the list of JSON maps; otherwise,
  /// it returns `null` if no data is found.
  Future<List<Map<String, dynamic>>?> getJsonList({required String key});
}

/// Interface for writing cache operations.
///
/// Provides methods to store values in the cache with specific keys.
abstract interface class ICommandPrefsCachaManagerController {
  /// Saves a string value in the cache with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  Future<void> saveString({required String key, required String data});

  /// Saves an integer value in the cache with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  Future<void> saveInt({required String key, required int data});

  /// Saves a JSON map in the cache with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. The data must be a `Map<String, dynamic>`.
  Future<void> saveJson({required String key, required Map<String, dynamic> data});

  /// Saves a list of strings in the cache with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. The data must be a list of strings.
  Future<void> saveStringList({required String key, required List<String> data});

  /// Saves a list of JSON objects in the cache with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. The data must be a list of JSON objects
  /// represented as maps with `String` keys and dynamic values.
  Future<void> saveJsonList({required String key, required List<Map<String, dynamic>> data});

  /// Deletes the cache entry for the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  Future<void> delete({required String key});

  /// Clears all entries from the cache.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the cache has been cleared.
  Future<void> clear();
}
