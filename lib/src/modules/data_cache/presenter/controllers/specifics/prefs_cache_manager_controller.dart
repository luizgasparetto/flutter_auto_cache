part of '../base_cache_manager_controller.dart';

/// A controller class for managing key-value storage cache operations.
///
/// This class provides methods to retrieve and save string, integer, and
/// double values in a cache, abstracting the underlying cache mechanism
/// provided by [BaseCacheManagerController].
class PrefsCacheManagerController {
  final BaseCacheManagerController _baseCacheManagerController;

  @visibleForTesting
  const PrefsCacheManagerController(this._baseCacheManagerController);

  PrefsCacheManagerController._() : _baseCacheManagerController = BaseCacheManagerController.prefs();

  static final _instance = PrefsCacheManagerController._();

  static PrefsCacheManagerController get instance => _instance;

  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `Future<String?>` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  Future<String?> getString({required String key}) async {
    return _baseCacheManagerController.get<String>(key: key);
  }

  /// Retrieves an integer value from the cache for the given `key`.
  ///
  /// Returns a `Future<int?>` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  Future<int?> getInt({required String key}) async {
    return _baseCacheManagerController.get<int>(key: key);
  }

  /// Retrieves a JSON map from the cache associated with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<Map<String, dynamic>?>`.
  /// It returns the JSON map if it exists or `null` if no data is found for the `key`.
  Future<Map<String, dynamic>?> getJson({required String key}) async {
    return _baseCacheManagerController.get<Map<String, dynamic>>(key: key);
  }

  /// Saves a `String` in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  Future<void> saveString({required String key, required String data}) async {
    return _baseCacheManagerController.save<String>(key: key, data: data);
  }

  /// Saves an `int` in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  Future<void> saveInt({required String key, required int data}) async {
    return _baseCacheManagerController.save<int>(key: key, data: data);
  }

  /// Saves a JSON map in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. The data must be a `Map<String, dynamic>`.
  Future<void> saveJson({required String key, required Map<String, dynamic> data}) async {
    return _baseCacheManagerController.save<Map<String, dynamic>>(key: key, data: data);
  }
}
