import '../../../../../auto_cache_manager_library.dart';
import '../../../../core/core.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/exceptions/cache_exceptions.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

part 'specifics/kvs_cache_manager_controller.dart';
part 'specifics/sql_cache_manager_controller.dart';

class _BaseCacheManagerController {
  final GetCacheUsecase _getCacheUsecase;
  final SaveCacheUsecase _saveCacheUsecase;

  _BaseCacheManagerController(this._getCacheUsecase, this._saveCacheUsecase);

  static final _BaseCacheManagerController _instance = _BaseCacheManagerController.fromInjector();

  static _BaseCacheManagerController get instance => _instance;

  factory _BaseCacheManagerController.fromInjector() {
    return _BaseCacheManagerController(
      Injector.instance.get<GetCacheUsecase>(),
      Injector.instance.get<SaveCacheUsecase>(),
    );
  }

  Future<T?> get<T>({required String key}) async {
    final isInitialized = AutoCacheManagerInitialazer.instance.isInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException();
    }

    final response = await _getCacheUsecase.execute<T>(key: key);

    return response.fold(
      (error) => throw error,
      (success) => success?.data,
    );
  }

  Future<void> save<T>({required String key, required T data}) async {
    final isInitialized = AutoCacheManagerInitialazer.instance.isInitialized;

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
