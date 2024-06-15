import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/stores/auto_cache_config_store.dart';
import 'core/core.dart';

import 'core/services/compressor_service/i_compressor_service.dart';
import 'core/services/compressor_service/implementations/compressor_service.dart';
import 'core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'core/services/cryptography_service/i_cryptography_service.dart';
import 'core/services/directory_service/path_provider/path_provider_service.dart';
import 'core/services/storages/prefs/i_prefs_service.dart';
import 'core/services/storages/prefs/shared_preferences/shared_preferences_service.dart';

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

  static bool get isInjectorInitialized => Injector.I.hasBinds;

  void resetBinds() => Injector.I.clear();

  Future<void> registerBinds() async {
    await _registerLibs();
    _registerCore();
    _registerDataCache();
  }

  Future<void> _registerLibs() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);
  }

  void _registerCore() {
    Injector.I.bindSingleton<CacheConfig>(AutoCacheConfigStore.instance.config);
    Injector.I.bindSingleton<IPathProviderService>(PathProviderService());
    Injector.I.bindSingleton<ICompressorService>(CompressorService());
    Injector.I.bindSingleton<IPrefsService>(SharedPreferencesService(_get()));
    Injector.I.bindSingleton<ICryptographyService>(EncryptCryptographyService(_get()));
    Injector.I.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(_get()));
  }

  void _registerDataCache() {
    Injector.I.bindFactory<IQueryDataCacheDatasource>(() => QueryDataCacheDatasource(_get(), _get()));
    Injector.I.bindFactory<ICommandDataCacheDatasource>(() => CommandDataCacheDatasource(_get(), _get()));
    Injector.I.bindFactory<IInvalidationCacheContext>(() => InvalidationCacheContext(_get()));
    Injector.I.bindFactory<ICacheRepository>(() => CacheRepository(_get(), _get()));
    Injector.I.bindFactory<DeleteCacheUsecase>(() => DeleteCache(_get()));
    Injector.I.bindFactory<ClearCacheUsecase>(() => ClearCache(_get()));
    Injector.I.bindFactory<GetCacheUsecase>(() => GetCache(_get(), _get()));
    Injector.I.bindFactory<SaveCacheUsecase>(() => SaveCache(_get(), _get()));
  }

  T _get<T extends Object>() => Injector.I.get<T>();
}
