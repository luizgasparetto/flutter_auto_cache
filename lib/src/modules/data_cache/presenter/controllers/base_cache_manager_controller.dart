import 'package:meta/meta.dart';

import '../../../../core/core.dart';
import '../../../../core/middlewares/init_middleware.dart';
import '../../domain/dtos/delete_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/usecases/clear_cache_usecase.dart';
import '../../domain/usecases/delete_cache_usecase.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

part 'specifications/prefs_cache_manager_controller.dart';

class BaseCacheManagerController {
  final GetCacheUsecase _getCacheUsecase;
  final SaveCacheUsecase _saveCacheUsecase;
  final ClearCacheUsecase _clearCacheUsecase;
  final DeleteCacheUsecase _deleteCacheUsecase;
  final CacheConfig cacheConfig;

  const BaseCacheManagerController(
    this._getCacheUsecase,
    this._saveCacheUsecase,
    this._clearCacheUsecase,
    this._deleteCacheUsecase,
    this.cacheConfig,
  );

  static BaseCacheManagerController create() {
    return BaseCacheManagerController(
      Injector.I.get<GetCacheUsecase>(),
      Injector.I.get<SaveCacheUsecase>(),
      Injector.I.get<ClearCacheUsecase>(),
      Injector.I.get<DeleteCacheUsecase>(),
      Injector.I.get<CacheConfig>(),
    );
  }

  Future<T?> get<T extends Object>({required String key}) async {
    return _getDataCache.call<T, Object>(key: key);
  }

  Future<T?> getList<T extends Object, DataType extends Object>({required String key}) {
    return _getDataCache<T, DataType>(key: key);
  }

  Future<T?> _getDataCache<T extends Object, DataType extends Object>({required String key}) async {
    final dto = GetCacheDTO(key: key);

    final response = await _getCacheUsecase.execute<T, DataType>(dto);

    return response.fold((error) => throw error, (success) => success?.data);
  }

  Future<void> save<T extends Object>({required String key, required T data}) async {
    final dto = SaveCacheDTO<T>(key: key, data: data, cacheConfig: cacheConfig);
    final response = await _saveCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }

  Future<void> delete({required String key}) async {
    final dto = DeleteCacheDTO(key: key);
    final response = await _deleteCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }

  Future<void> clear() async {
    final response = await _clearCacheUsecase.execute();

    if (response.isError) {
      throw response.error;
    }
  }
}
