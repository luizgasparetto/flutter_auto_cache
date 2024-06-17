part of '../base_cache_manager_controller.dart';

/// Combines query and command cache management operations
///
/// This mixin unites the read and write cache operations defined in
/// [IQueryPrefsCacheManagerController] and [ICommandPrefsCacheManagerController].
mixin IPrefsCacheManagerController on IQueryPrefsCacheManagerController, ICommandPrefsCachaManagerController {}

/// Interface for querying cache operations.
///
/// Provides methods to retrieve cached values in different data types.
abstract interface class IQueryPrefsCacheManagerController {
  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `String?` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  String? getString({required String key});

  /// Retrieves an integer value from the cache for the given [key].
  ///
  /// Returns a `int?` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  int? getInt({required String key});

  /// Retrieves a JSON map from the cache associated with the specified [key].
  ///
  /// This method is asynchronous and returns a `Map<String, dynamic>?`.
  /// It returns the JSON map if it exists, or `null` if no data is found for the [key].
  Map<String, dynamic>? getJson({required String key});

  /// Retrieves a list of strings from the cache associated with the specified [key].
  ///
  /// This method is asynchronous and returns a `Future<List<String>?>`.
  /// If the data exists for the [key], it returns the list; otherwise,
  /// it returns `null` if no data is found.
  List<String>? getStringList({required String key});

  /// Retrieves a list of JSON maps from the cache associated with the specified [key].
  ///
  /// This method returns a `List<Map<String, dynamic>>?`.
  /// If the data exists for the [key], it returns the list of JSON maps; otherwise,
  /// it returns `null` if no data is found.
  List<Map<String, dynamic>>? getJsonList({required String key});
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

/// A controller class for managing key-value storage cache operations.
///
/// This class provides methods to retrieve and save string, integer,
/// and JSON values in a cache, abstracting the underlying cache mechanism
/// provided by [BaseCacheManagerController].
class PrefsCacheManagerController implements IPrefsCacheManagerController {
  final BaseCacheManagerController _baseCacheManagerController;

  @visibleForTesting
  const PrefsCacheManagerController(this._baseCacheManagerController);

  PrefsCacheManagerController._() : _baseCacheManagerController = BaseCacheManagerController.create();

  static final _instance = InitializeMiddleware.accessInstance(() => PrefsCacheManagerController._());

  static PrefsCacheManagerController get instance => _instance;

  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `String?` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  String? getString({required String key}) {
    return _baseCacheManagerController.get<String>(key: key);
  }

  /// Retrieves an integer value from the cache for the given [key].
  ///
  /// Returns an `int?` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  int? getInt({required String key}) {
    return _baseCacheManagerController.get<int>(key: key);
  }

  /// Retrieves a JSON map from the cache associated with the specified [key].
  ///
  /// Returns a `Map<String, dynamic>?` that completes with the JSON map
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Map<String, dynamic>? getJson({required String key}) {
    return _baseCacheManagerController.get<Map<String, dynamic>>(key: key);
  }

  /// Retrieves a list of strings from the cache associated with the specified [key].
  ///
  /// Returns a `List<String>?` that completes with the list of strings
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  List<String>? getStringList({required String key}) {
    return _baseCacheManagerController.getList<String>(key: key);
  }

  /// Retrieves a list of JSON maps from the cache associated with the specified [key].
  ///
  /// Returns a `List<Map<String, dynamic>>?` that completes with the list of JSON maps
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  List<Map<String, dynamic>>? getJsonList({required String key}) {
    return _baseCacheManagerController.getList<Map<String, dynamic>>(key: key);
  }

  /// Saves a `String` in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveString({required String key, required String data}) async {
    return _baseCacheManagerController.save<String>(key: key, data: data);
  }

  /// Saves an `int` in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveInt({required String key, required int data}) async {
    return _baseCacheManagerController.save<int>(key: key, data: data);
  }

  /// Saves a JSON map in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveJson({required String key, required Map<String, dynamic> data}) async {
    return _baseCacheManagerController.save<Map<String, dynamic>>(key: key, data: data);
  }

  /// Saves a list of strings in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveStringList({required String key, required List<String> data}) async {
    return _baseCacheManagerController.save<List<String>>(key: key, data: data);
  }

  /// Saves a list of JSON maps in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveJsonList({required String key, required List<Map<String, dynamic>> data}) async {
    return _baseCacheManagerController.save<List<Map<String, dynamic>>>(key: key, data: data);
  }

  /// Deletes the specified cache entry.
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  /// It removes the cache entry associated with the given [key].
  @override
  Future<void> delete({required String key}) async {
    return _baseCacheManagerController.delete(key: key);
  }

  /// Clears all entries from the cache.
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  /// This is useful for freeing up space or ensuring that outdated data is removed from the application.
  @override
  Future<void> clear() async {
    return _baseCacheManagerController.clear();
  }
}
