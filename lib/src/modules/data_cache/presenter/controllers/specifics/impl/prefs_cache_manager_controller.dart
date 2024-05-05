part of '../../base_cache_manager_controller.dart';

/// A controller class for managing key-value storage cache operations.
///
/// This class provides methods to retrieve and save string, integer, and
/// double values in a cache, abstracting the underlying cache mechanism
/// provided by [BaseCacheManagerController].
class PrefsCacheManagerController implements IPrefsCacheManagerController {
  final BaseCacheManagerController _baseCacheManagerController;

  @visibleForTesting
  const PrefsCacheManagerController(this._baseCacheManagerController);

  PrefsCacheManagerController._() : _baseCacheManagerController = BaseCacheManagerController.prefs();

  static final _instance = InitMiddleware.accessInstance(() => PrefsCacheManagerController._());

  static PrefsCacheManagerController get instance => _instance;

  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `Future<String?>` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<String?> getString({required String key}) async {
    return _baseCacheManagerController.get<String>(key: key);
  }

  /// Retrieves an integer value from the cache for the given `key`.
  ///
  /// Returns a `Future<int?>` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<int?> getInt({required String key}) async {
    return _baseCacheManagerController.get<int>(key: key);
  }

  /// Retrieves a JSON map from the cache associated with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<Map<String, dynamic>?>`.
  /// It returns the JSON map if it exists or `null` if no data is found for the `key`.
  @override
  Future<Map<String, dynamic>?> getJson({required String key}) async {
    return _baseCacheManagerController.get<Map<String, dynamic>>(key: key);
  }

  /// Retrieves a list of objects from the cache associated with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<List<T>?>`. It fetches a list of
  /// objects where each object is of type `String`. If the data exists for the `key`, it returns
  /// the list; otherwise, it returns `null` if no data is found.
  @override
  Future<List<String>?> getStringList({required String key}) async {
    return _baseCacheManagerController.get<List<String>>(key: key);
  }

  /// Saves a `String` in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  @override
  Future<void> saveString({required String key, required String data}) async {
    return _baseCacheManagerController.save<String>(key: key, data: data);
  }

  /// Saves an `int` in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished.
  @override
  Future<void> saveInt({required String key, required int data}) async {
    return _baseCacheManagerController.save<int>(key: key, data: data);
  }

  /// Saves a JSON map in the cache with the specified `key`.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. The data must be a `Map<String, dynamic>`.
  @override
  Future<void> saveJson({required String key, required Map<String, dynamic> data}) async {
    return _baseCacheManagerController.save<Map<String, dynamic>>(key: key, data: data);
  }

  /// Stores a list of objects in the cache under the specified `key`.
  ///
  /// This method is asynchronous and does not return a value. It saves a list of
  /// objects, where each object is of type `String`, to the cache. The `data` is the list
  /// of objects to be stored, and `key` is the identifier used to retrieve the list
  /// from the cache later.
  @override
  Future<void> saveStringList({required String key, required List<String> data}) async {
    return _baseCacheManagerController.save<List<String>>(key: key, data: data);
  }

  /// Deletes the specified cache entry.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// when the operation is finished. It removes the cache entry associated
  /// with the given `key`.
  @override
  Future<void> delete({required String key}) async {
    return _baseCacheManagerController.delete(key: key);
  }

  /// Clears all entries from the cache.
  ///
  /// This method performs an asynchronous operation to remove all entries
  /// from the cache. It returns a `Future<void>` that completes when the
  /// cache has been cleared. This is useful for freeing up space or ensuring
  /// that outdated data is removed from the application.
  @override
  Future<void> clear() async {
    return _baseCacheManagerController.clear();
  }
}
