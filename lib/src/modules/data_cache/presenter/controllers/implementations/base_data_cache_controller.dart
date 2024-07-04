import 'package:meta/meta.dart';

import '../../../../../core/core.dart';
import '../../../../../core/infrastructure/middlewares/initialize_middleware.dart';
import '../../../../../core/services/service_locator/implementations/service_locator.dart';

import '../../../domain/dtos/key_cache_dto.dart';
import '../../../domain/dtos/write_cache_dto.dart';
import '../../../domain/usecases/clear_data_cache_usecase.dart';
import '../../../domain/usecases/delete_data_cache_usecase.dart';
import '../../../domain/usecases/get_data_cache_usecase.dart';
import '../../../domain/usecases/write_data_cache_usecase.dart';
import '../i_base_data_cache_controller.dart';

part 'data_cache_controller.dart';
part '../i_data_cache_controller.dart';

class BaseDataCacheController implements IBaseDataCacheController {
  final IGetDataCacheUsecase _getCacheUsecase;
  final IWriteDataCacheUsecase _writeCacheUsecase;
  final IClearDataCacheUsecase _clearCacheUsecase;
  final IDeleteDataCacheUsecase _deleteCacheUsecase;
  final CacheConfiguration cacheConfiguration;

  const BaseDataCacheController(
    this._getCacheUsecase,
    this._writeCacheUsecase,
    this._clearCacheUsecase,
    this._deleteCacheUsecase,
    this.cacheConfiguration,
  );

  factory BaseDataCacheController.create() {
    return BaseDataCacheController(
      ServiceLocator.instance.get<IGetDataCacheUsecase>(),
      ServiceLocator.instance.get<IWriteDataCacheUsecase>(),
      ServiceLocator.instance.get<IClearDataCacheUsecase>(),
      ServiceLocator.instance.get<IDeleteDataCacheUsecase>(),
      ServiceLocator.instance.get<CacheConfiguration>(),
    );
  }

  @override
  Future<T?> get<T extends Object>({required String key}) async {
    return _getDataCache.call<T, T>(key: key);
  }

  @override
  Future<List<T>?> getList<T extends Object>({required String key}) async {
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
    final dto = KeyCacheDTO(key: key);
    final response = await _deleteCacheUsecase.execute(dto);

    return response.fold((error) => throw error, (_) {});
  }

  @override
  Future<void> clear() async {
    final response = await _clearCacheUsecase.execute();

    return response.fold((error) => throw error, (_) {});
  }

  Future<T?> _getDataCache<T extends Object, DataType extends Object>({required String key}) async {
    final dto = KeyCacheDTO(key: key);

    final response = await _getCacheUsecase.execute<T, DataType>(dto);
    return response.fold((error) => throw error, (success) => success?.data);
  }
}
