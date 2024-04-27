import 'package:flutter/foundation.dart';

import '../../../../auto_cache_manager_initializer.dart';
import '../../../../core/core.dart';
import '../../../../core/exceptions/initializer_exceptions.dart';
import '../../domain/dtos/clear_cache_dto.dart';
import '../../domain/dtos/delete_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/enums/storage_type.dart';
import '../../domain/usecases/clear_cache_usecase.dart';
import '../../domain/usecases/delete_cache_usecase.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

part 'specifics/prefs_cache_manager_controller.dart';
part 'specifics/sql_cache_manager_controller.dart';

class BaseCacheManagerController {
  final GetCacheUsecase _getCacheUsecase;
  final SaveCacheUsecase _saveCacheUsecase;
  final ClearCacheUsecase _clearCacheUsecase;
  final DeleteCacheUsecase _deleteCacheUsecase;
  final CacheConfig cacheConfig;
  final StorageType storageType;

  const BaseCacheManagerController(
    this._getCacheUsecase,
    this._saveCacheUsecase,
    this._clearCacheUsecase,
    this._deleteCacheUsecase,
    this.cacheConfig, {
    required this.storageType,
  });

  factory BaseCacheManagerController.prefs() => _create(StorageType.prefs);
  factory BaseCacheManagerController.sql() => _create(StorageType.sql);

  static BaseCacheManagerController _create(StorageType storageType) {
    return BaseCacheManagerController(
      Injector.I.get<GetCacheUsecase>(),
      Injector.I.get<SaveCacheUsecase>(),
      Injector.I.get<ClearCacheUsecase>(),
      Injector.I.get<DeleteCacheUsecase>(),
      Injector.I.get<CacheConfig>(),
      storageType: storageType,
    );
  }

  Future<T?> get<T extends Object>({required String key}) async {
    _initializedConfigVerification();

    final dto = GetCacheDTO(key: key, storageType: storageType);

    final response = await _getCacheUsecase.execute<T>(dto);

    return response.fold(
      (error) => throw error,
      (success) => success?.data,
    );
  }

  Future<void> save<T extends Object>({required String key, required T data}) async {
    _initializedConfigVerification();

    final dto = SaveCacheDTO<T>(key: key, data: data, storageType: storageType, cacheConfig: cacheConfig);
    final response = await _saveCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }

  Future<void> delete({required String key}) async {
    _initializedConfigVerification();

    final dto = DeleteCacheDTO(key: key, storageType: storageType);
    final response = await _deleteCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }

  Future<void> clear() async {
    _initializedConfigVerification();

    final dto = ClearCacheDTO(storageType: storageType);
    final response = await _clearCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }

  void _initializedConfigVerification() {
    final isInitialized = AutoCacheManagerInitializer.instance.isInjectorInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException(
        message: 'Auto cache manager is not initialized',
        stackTrace: StackTrace.current,
      );
    }
  }
}
