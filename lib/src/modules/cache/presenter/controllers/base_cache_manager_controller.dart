import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';

import '../../../../../auto_cache_manager.dart';
import '../../../../core/core.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/exceptions/cache_exceptions.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

part 'specifics/kvs_cache_manager_controller.dart';
part 'specifics/sql_cache_manager_controller.dart';

class BaseCacheManagerController {
  final GetCacheUsecase _getCacheUsecase;
  final SaveCacheUsecase _saveCacheUsecase;
  final StorageType storageType;

  const BaseCacheManagerController(
    this._getCacheUsecase,
    this._saveCacheUsecase, {
    required this.storageType,
  });

  factory BaseCacheManagerController._kvs() {
    return BaseCacheManagerController(
      Injector.I.get<GetCacheUsecase>(),
      Injector.I.get<SaveCacheUsecase>(),
      storageType: StorageType.kvs,
    );
  }

  factory BaseCacheManagerController._sql() {
    return BaseCacheManagerController(
      Injector.I.get<GetCacheUsecase>(),
      Injector.I.get<SaveCacheUsecase>(),
      storageType: StorageType.sql,
    );
  }

  Future<T?> get<T extends Object>({required String key}) async {
    final isInitialized = AutoCacheManagerInitialazer.I.isInjectorInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException();
    }

    final response = await _getCacheUsecase.execute<T>(key: key);

    return response.fold(
      (error) => throw error,
      (success) => success?.data,
    );
  }

  Future<void> save<T extends Object>({required String key, required T data}) async {
    final isInitialized = AutoCacheManagerInitialazer.I.isInjectorInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException();
    }

    final dto = SaveCacheDTO<T>.withConfig(key: key, data: data);

    final response = await _saveCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }
}
