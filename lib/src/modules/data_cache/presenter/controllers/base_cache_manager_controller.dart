import 'package:meta/meta.dart';

import '../../../../core/core.dart';
import '../../../../core/infrastructure/middlewares/initialize_middleware.dart';
import '../../../../core/services/service_locator/implementations/service_locator.dart';

import '../../domain/dtos/delete_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/usecases/clear_cache_usecase.dart';
import '../../domain/usecases/delete_cache_usecase.dart';
import '../../domain/usecases/get_data_cache_usecase.dart';
import '../../domain/usecases/write_cache_usecase.dart';

part 'specifications/implementations/prefs_cache_manager_controller.dart';
part 'specifications/i_prefs_cache_manager_controller.dart';

/// Responsible for managing caching operations through various use cases.
/// The `BaseCacheManagerController` provides an abstraction layer for interacting
/// with cached data by offering comprehensive methods for retrieval, saving,
/// deletion, and clearing of cache content.
class BaseCacheManagerController {
  final IGetDataCacheUsecase _getCacheUsecase;
  final IWriteCacheUsecase _writeCacheUsecase;
  final ClearCacheUsecase _clearCacheUsecase;
  final DeleteCacheUsecase _deleteCacheUsecase;
  final CacheConfig cacheConfig;

  /// Initializes the `BaseCacheManagerController` with the specified use cases and cache configuration.
  ///
  /// This constructor requires explicit implementations of the following use cases to ensure a consistent cache
  /// management experience across various application scenarios:
  ///
  /// - [_getCacheUsecase]: Provides data retrieval operations.
  /// - [_saveCacheUsecase]: Handles saving data into the cache.
  /// - [_clearCacheUsecase]: Facilitates clearing the entire cache.
  /// - [_deleteCacheUsecase]: Manages the removal of specific cache entries.
  /// - [cacheConfig]: Supplies specific cache configuration options to guide caching behavior.
  const BaseCacheManagerController(
    this._getCacheUsecase,
    this._writeCacheUsecase,
    this._clearCacheUsecase,
    this._deleteCacheUsecase,
    this.cacheConfig,
  );

  /// Factory method for creating a new instance of `BaseCacheManagerController`.
  ///
  /// This method utilizes a dependency injection framework to automatically
  /// retrieve the required use cases and cache configuration, offering a ready-to-use
  /// implementation for cache management.
  static BaseCacheManagerController create() {
    return BaseCacheManagerController(
      ServiceLocator.instance.get<IGetDataCacheUsecase>(),
      ServiceLocator.instance.get<IWriteCacheUsecase>(),
      ServiceLocator.instance.get<ClearCacheUsecase>(),
      ServiceLocator.instance.get<DeleteCacheUsecase>(),
      ServiceLocator.instance.get<CacheConfig>(),
    );
  }

  /// Fetches a cached object of type [T] corresponding to the specified [key].
  ///
  /// - [key]: A unique identifier associated with the desired cached object.
  ///
  /// Returns the cached object of type [T] if found, or `null` if not present.
  ///
  /// Throws an error if data retrieval fails.
  T? get<T extends Object>({required String key}) {
    return _getDataCache.call<T, T>(key: key);
  }

  /// Retrieves a list of cached objects of type [T] associated with the specified [key].
  ///
  /// - [key]: A unique identifier linked to the desired cached list.
  ///
  /// Returns a list of cached objects if found, or `null` if not present.
  ///
  /// Throws an error if data retrieval encounters an issue.
  List<T>? getList<T extends Object>({required String key}) {
    return _getDataCache<List<T>, T>(key: key);
  }

  /// Saves an object of type [T] into the cache under the provided [key].
  ///
  /// - [key]: The unique identifier to associate with the cached object.
  /// - [data]: The object to be saved in the cache.
  ///
  /// Throws an exception if the cache save operation encounters an error.
  Future<void> save<T extends Object>({required String key, required T data}) async {
    final dto = WriteCacheDTO<T>(key: key, data: data, cacheConfig: cacheConfig);
    final response = await _writeCacheUsecase.execute(dto);

    return response.foldLeft((error) => throw error);
  }

  /// Deletes a specific cached entry identified by the given [key].
  ///
  /// - [key]: The unique identifier associated with the cache entry to be deleted.
  ///
  /// Throws an exception if the cache deletion operation encounters an error.
  Future<void> delete({required String key}) async {
    final dto = DeleteCacheDTO(key: key);
    final response = await _deleteCacheUsecase.execute(dto);

    return response.foldLeft((error) => throw error);
  }

  /// Clears all cache entries stored within the cache system.
  ///
  /// Throws an exception if the cache clearing operation encounters an error.
  Future<void> clear() async {
    final response = await _clearCacheUsecase.execute();

    return response.foldLeft((error) => throw error);
  }

  /// Retrieves a cached object of type [T] identified by the specified [key].
  ///
  /// - [key]: The unique identifier associated with the desired cached object.
  ///
  /// Returns the cached object of type [T], or `null` if not found.
  ///
  /// Throws an error if data retrieval fails.
  T? _getDataCache<T extends Object, DataType extends Object>({required String key}) {
    final dto = GetCacheDTO(key: key);

    final response = _getCacheUsecase.execute<T, DataType>(dto);

    return response.fold((error) => throw error, (success) => success?.data);
  }
}
