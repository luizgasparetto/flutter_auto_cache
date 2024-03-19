part of '../base_cache_manager_controller.dart';

/// A controller class for managing SQL-based cache operations.
///
/// This class provides a generic interface for retrieving and saving data
/// of any type in a cache, utilizing the underlying cache mechanism provided
/// by `_BaseCacheManagerController`. It is designed to work with SQL databases
/// to cache data, making data retrieval and storage operations more efficient.
class SQLCacheManagerController {
  final BaseCacheManagerController _baseCacheManagerController;

  /// Constructs a singleton instance of `SQLCacheManagerController`.
  ///
  /// This constructor is private to ensure that `SQLCacheManagerController`
  /// can only be accessed through its singleton instance, maintaining a single
  /// point of interaction with the SQL-based cache system.
  SQLCacheManagerController._() : _baseCacheManagerController = BaseCacheManagerController._sql();

  /// The singleton instance of `SQLCacheManagerController`.
  ///
  /// Use this instance to access SQL-based cache functionality throughout
  /// your application.
  static final SQLCacheManagerController _instance = SQLCacheManagerController._();

  /// Provides access to the singleton instance of `SQLCacheManagerController`.
  static SQLCacheManagerController get instance => _instance;

  /// Retrieves a cached value of type [T] associated with the specified `key`.
  ///
  /// This generic method allows for the retrieval of any data type from the cache,
  /// provided it extends `Object`. If the key is found, it returns a `Future<T?>`
  /// that completes with the value. If the key is not found, it returns `null`.
  ///
  /// - Parameters:
  ///   - key: The unique key associated with the cached value.
  /// - Returns: A `Future<T?>` that completes with the cached value of type [T]
  ///   if it exists, or `null` if the key is not found.
  Future<T?> get<T extends Object>({required String key}) async {
    return _baseCacheManagerController.get<T>(key: key);
  }

  /// Saves a value of `Object` type in the cache with the specified `key`.
  ///
  /// This method abstracts the underlying SQL-based cache storage mechanism,
  /// allowing for efficient data saving operations. The method is generic,
  /// supporting any type that extends `Object`.
  ///
  /// - Parameters:
  ///   - key: The unique key to associate with the value in the cache.
  ///   - data: The data to be saved in the cache. It must extend `Object`.
  /// - Returns: A `Future<void>` that completes when the operation is finished.
  Future<void> save<T extends Object>({required String key, required T data}) async {
    return _baseCacheManagerController.save<Object>(key: key, data: data);
  }
}
