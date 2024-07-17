part of 'base_data_cache_controller.dart';

/// A controller class for managing key-value storage cache operations.
///
/// This class provides methods to retrieve and save string, integer,
/// and JSON values in a cache, abstracting the underlying cache mechanism
/// provided by [IDataCacheController].
final class DataCacheController implements IDataCacheController {
  final IBaseDataCacheController _baseDataCacheController;

  @visibleForTesting
  const DataCacheController(this._baseDataCacheController);

  DataCacheController._() : _baseDataCacheController = BaseDataCacheController.create();

  static final _instance = DataCacheController._();

  static DataCacheController get instance => InitializeMiddleware.accessInstance(() => _instance);

  /// Retrieves a string value from the cache for the given [key].
  ///
  /// Returns a `String?` that completes with the string value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<CacheResponse<String?>> getString({required String key}) async {
    return _baseDataCacheController.get<String>(key: key);
  }

  /// Retrieves an integer value from the cache for the given [key].
  ///
  /// Returns an `int?` that completes with the integer value
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<CacheResponse<int?>> getInt({required String key}) async {
    return _baseDataCacheController.get<int>(key: key);
  }

  /// Retrieves a JSON map from the cache associated with the specified [key].
  ///
  /// Returns a `Map<String, dynamic>?` that completes with the JSON map
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<CacheResponse<Map<String, dynamic>?>> getJson({required String key}) async {
    return _baseDataCacheController.get<Map<String, dynamic>>(key: key);
  }

  /// Retrieves a list of strings from the cache associated with the specified [key].
  ///
  /// Returns a `List<String>?` that completes with the list of strings
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<CacheResponse<List<String>?>> getStringList({required String key}) async {
    return _baseDataCacheController.getList<String>(key: key);
  }

  /// Retrieves a list of JSON maps from the cache associated with the specified [key].
  ///
  /// Returns a `List<Map<String, dynamic>>?` that completes with the list of JSON maps
  /// associated with `key` if it exists, or `null` if the key is not found.
  @override
  Future<CacheResponse<List<Map<String, dynamic>>?>> getJsonList({required String key}) async {
    return _baseDataCacheController.getList<Map<String, dynamic>>(key: key);
  }

  /// Saves a `String` in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveString({required String key, required String data}) async {
    return _baseDataCacheController.save<String>(key: key, data: data);
  }

  /// Saves an `int` in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveInt({required String key, required int data}) async {
    return _baseDataCacheController.save<int>(key: key, data: data);
  }

  /// Saves a JSON map in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveJson({required String key, required Map<String, dynamic> data}) async {
    return _baseDataCacheController.save<Map<String, dynamic>>(key: key, data: data);
  }

  /// Saves a list of strings in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveStringList({required String key, required List<String> data}) async {
    return _baseDataCacheController.save<List<String>>(key: key, data: data);
  }

  /// Saves a list of JSON maps in the cache with the specified [key].
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  @override
  Future<void> saveJsonList({required String key, required List<Map<String, dynamic>> data}) async {
    return _baseDataCacheController.save<List<Map<String, dynamic>>>(key: key, data: data);
  }

  /// Deletes the specified cache entry.
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  /// It removes the cache entry associated with the given [key].
  @override
  Future<void> delete({required String key}) async {
    return _baseDataCacheController.delete(key: key);
  }

  /// Clears all entries from the cache.
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  /// This is useful for freeing up space or ensuring that outdated data is removed from the application.
  @override
  Future<void> clear() async {
    return _baseDataCacheController.clear();
  }
}
