import '../../../../../auto_cache_manager.dart';
import '../../../../core/core.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/exceptions/cache_exceptions.dart';
import '../../domain/usecases/get_cache_usecase.dart';
import '../../domain/usecases/save_cache_usecase.dart';

class AutoCacheManager {
  AutoCacheManager._();

  static final AutoCacheManager _instance = AutoCacheManager._();

  static AutoCacheManager get instance => _instance;

  Future<String?> getString({required String key}) async {
    return get<String>(key: key);
  }

  Future<int?> getInt({required String key}) async {
    return get<int>(key: key);
  }

  Future<double?> getDouble({required String key}) async {
    return get<double>(key: key);
  }

  Future<T?> getObject<T extends Object>({required String key}) async {
    return get<T>(key: key);
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

  Future<void> saveObject<T extends Object>({required String key, required T data}) async {
    return save<T>(key: key, data: data);
  }

  Future<T?> get<T>({required String key}) async {
    final isInitialized = AutoCacheManagerInitialazer.instance.isInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException();
    }

    final usecase = Injector.instance.get<GetCacheUsecase>();
    final response = await usecase.execute<T>(key: key);

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

    final usecase = Injector.instance.get<SaveCacheUsecase>();
    final dto = SaveCacheDTO<T>(key: key, data: data);

    final response = await usecase.execute(dto);

    if (response.isError) {
      throw response.error;
    }
  }
}
