import 'package:meta/meta.dart';

import '../../../../../core/core.dart';
import '../../../../../core/infrastructure/middlewares/initialize_middleware.dart';
import '../../../../../core/services/service_locator/implementations/service_locator.dart';

import '../../../domain/dtos/delete_cache_dto.dart';
import '../../../domain/dtos/get_cache_dto.dart';
import '../../../domain/dtos/write_cache_dto.dart';
import '../../../domain/usecases/clear_data_cache_usecase.dart';
import '../../../domain/usecases/delete_data_cache_usecase.dart';
import '../../../domain/usecases/get_data_cache_usecase.dart';
import '../../../domain/usecases/write_data_cache_usecase.dart';

import '../i_data_cache_controller.dart';

part 'prefs_cache_manager_controller.dart';
part '../i_prefs_cache_manager_controller.dart';

/// Responsible for managing caching operations through various use cases.
/// The `BaseDataCacheManagerController` provides an abstraction layer for interacting
/// with cached data by offering comprehensive methods for retrieval, saving,
/// deletion, and clearing of cache content.
class DataCacheManagerController implements IDataCacheController {
  final IGetDataCacheUsecase _getCacheUsecase;
  final IWriteDataCacheUsecase _writeCacheUsecase;
  final IClearDataCacheUsecase _clearCacheUsecase;
  final IDeleteDataCacheUsecase _deleteCacheUsecase;
  final CacheConfiguration cacheConfiguration;

  /// Initializes the `BaseDataCacheManagerController` with the specified use cases and cache configuration.
  ///
  /// This constructor requires explicit implementations of the following use cases to ensure a consistent cache
  /// management experience across various application scenarios:
  ///
  /// - [_getCacheUsecase]: Provides data retrieval operations.
  /// - [_saveCacheUsecase]: Handles saving data into the cache.
  /// - [_clearCacheUsecase]: Facilitates clearing the entire cache.
  /// - [_deleteCacheUsecase]: Manages the removal of specific cache entries.
  /// - [cacheConfig]: Supplies specific cache configuration options to guide caching behavior.
  const DataCacheManagerController(
    this._getCacheUsecase,
    this._writeCacheUsecase,
    this._clearCacheUsecase,
    this._deleteCacheUsecase,
    this.cacheConfiguration,
  );

  /// Factory method for creating a new instance of `BaseDataCacheManagerController`.
  ///
  /// This method utilizes a dependency injection framework to automatically
  /// retrieve the required use cases and cache configuration, offering a ready-to-use
  /// implementation for cache management.
  factory DataCacheManagerController.create() {
    return DataCacheManagerController(
      ServiceLocator.instance.get<IGetDataCacheUsecase>(),
      ServiceLocator.instance.get<IWriteDataCacheUsecase>(),
      ServiceLocator.instance.get<IClearDataCacheUsecase>(),
      ServiceLocator.instance.get<IDeleteDataCacheUsecase>(),
      ServiceLocator.instance.get<CacheConfiguration>(),
    );
  }

  @override
  T? get<T extends Object>({required String key}) {
    return _getDataCache.call<T, T>(key: key);
  }

  @override
  List<T>? getList<T extends Object>({required String key}) {
    return _getDataCache<List<T>, T>(key: key);
  }

  @override
  Future<void> save<T extends Object>({required String key, required T data}) async {
    final dto = WriteCacheDTO<T>(key: key, data: data, cacheConfig: cacheConfiguration);
    final response = await _writeCacheUsecase.execute(dto);

    return response.fold((error) => throw error, (_) {});
  }

  @override
  Future<void> delete({required String key}) async {
    final dto = DeleteCacheDTO(key: key);
    final response = await _deleteCacheUsecase.execute(dto);

    return response.fold((error) => throw error, (_) {});
  }

  @override
  Future<void> clear() async {
    final response = await _clearCacheUsecase.execute();

    return response.fold((error) => throw error, (_) {});
  }

  T? _getDataCache<T extends Object, DataType extends Object>({required String key}) {
    final dto = GetCacheDTO(key: key);

    final response = _getCacheUsecase.execute<T, DataType>(dto);
    return response.fold((error) => throw error, (success) => success?.data);
  }
}
