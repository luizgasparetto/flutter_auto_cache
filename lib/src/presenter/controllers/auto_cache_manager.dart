import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

class AutoCacheManager {
  final GetCacheUsecase _getCacheUsecase;
  final SaveCacheUsecase _saveCacheUsecase;

  const AutoCacheManager(this._getCacheUsecase, this._saveCacheUsecase);

  Future<String?> getString({required String key}) async {
    return get<String>(key: key);
  }

  Future<int?> getInt({required String key}) async {
    return get<int>(key: key);
  }

  Future<double?> getDouble({required String key}) async {
    return get<double>(key: key);
  }

  Future<void> saveString({required String key, required String data}) async {
    return save<String>(key: key, data: data);
  }

  Future<void> saveInt({required String key, required int data}) async {
    return save<int>(key: key, data: data);
  }

  Future<void> saveDouble({required String key, required double data}) async {
    return save<double>(key: key, data: data);
  }

  Future<T?> get<T>({required String key}) async {
    final response = await _getCacheUsecase.execute<T>(key: key);

    return response.fold(
      (error) => throw error,
      (success) => success?.data,
    );
  }

  Future<void> save<T>({required String key, required T data}) async {
    final dto = SaveCacheDTO<T>(key: key, data: data);

    final response = await _saveCacheUsecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }
}
