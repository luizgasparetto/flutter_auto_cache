import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/stores/cache_config_store.dart';
import 'core/core.dart';

import 'core/services/compressor_service/i_compressor_service.dart';
import 'core/services/compressor_service/implementations/compressor_service.dart';
import 'core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'core/services/cryptography_service/i_cryptography_service.dart';
import 'core/services/directory_service/path_provider/path_provider_service.dart';

import 'core/services/kvs_service/i_kvs_service.dart';
import 'core/services/kvs_service/implementations/shared_preferences_kvs_service.dart';
import 'core/services/service_locator/implementations/service_locator.dart';
import 'modules/data_cache/domain/repositories/i_cache_repository.dart';
import 'modules/data_cache/domain/services/invalidation/invalidation_cache_context.dart';
import 'modules/data_cache/domain/usecases/clear_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/delete_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/get_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/save_cache_usecase.dart';

import 'modules/data_cache/external/datasources/command_data_cache_datasource.dart';
import 'modules/data_cache/external/datasources/query_data_cache_datasource.dart';
import 'modules/data_cache/infra/datasources/i_command_data_cache_datasource.dart';
import 'modules/data_cache/infra/datasources/i_query_data_cache_datasource.dart';
import 'modules/data_cache/infra/repositories/cache_repository.dart';

class AutoCacheInjections {
  /// Private constructor for the singleton pattern.
  AutoCacheInjections._();

  /// The single instance of [AutoCacheManagerConfig].
  static final _instance = AutoCacheInjections._();

  /// Provides global access to the [AutoCacheInjections] instance.
  static AutoCacheInjections get instance => _instance;

  static bool get isInjectorInitialized => ServiceLocator.instance.hasBinds;

  Future<void> registerBinds() async {
    await _registerLibs();
    _registerCore();
    _registerDataCache();
  }

  Future<void> _registerLibs() async {
    await ServiceLocator.instance.asyncBind(SharedPreferences.getInstance);
  }

  void _registerCore() {
    ServiceLocator.instance.bindSingleton<CacheConfig>(CacheConfigStore.instance.config);
    ServiceLocator.instance.bindSingleton<IPathProviderService>(PathProviderService());
    ServiceLocator.instance.bindSingleton<ICompressorService>(CompressorService());
    ServiceLocator.instance.bindSingleton<IKVSService>(SharedPreferencesKVSService(_get()));
    ServiceLocator.instance.bindSingleton<ICryptographyService>(EncryptCryptographyService(_get()));
    ServiceLocator.instance.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(_get()));
  }

  void _registerDataCache() {
    ServiceLocator.instance.bindFactory<IQueryDataCacheDatasource>(() => QueryDataCacheDatasource(_get(), _get()));
    ServiceLocator.instance.bindFactory<ICommandDataCacheDatasource>(() => CommandDataCacheDatasource(_get(), _get()));
    ServiceLocator.instance.bindFactory<IInvalidationCacheContext>(() => InvalidationCacheContext(_get()));
    ServiceLocator.instance.bindFactory<ICacheRepository>(() => CacheRepository(_get(), _get()));
    ServiceLocator.instance.bindFactory<DeleteCacheUsecase>(() => DeleteCache(_get()));
    ServiceLocator.instance.bindFactory<ClearCacheUsecase>(() => ClearCache(_get()));
    ServiceLocator.instance.bindFactory<GetCacheUsecase>(() => GetCache(_get(), _get()));
    ServiceLocator.instance.bindFactory<SaveCacheUsecase>(() => SaveCache(_get(), _get()));
  }

  T _get<T extends Object>() => ServiceLocator.instance.get<T>();
}
