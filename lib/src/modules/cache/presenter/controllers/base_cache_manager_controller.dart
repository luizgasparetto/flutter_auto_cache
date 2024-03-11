import '../../../../../auto_cache_manager_library.dart';
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

  const BaseCacheManagerController(this._getCacheUsecase, this._saveCacheUsecase);

  factory BaseCacheManagerController._fromInjector() {
    return BaseCacheManagerController(
      Injector.I.get<GetCacheUsecase>(),
      Injector.I.get<SaveCacheUsecase>(),
    );
  }

  Future<T?> get<T extends Object>({required String key}) async {
    final isInitialized = AutoCacheManagerInitialazer.I.isInitialized;

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
    final isInitialized = AutoCacheManagerInitialazer.I.isInitialized;

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
