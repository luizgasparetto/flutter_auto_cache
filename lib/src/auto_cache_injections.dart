import 'package:shared_preferences/shared_preferences.dart';

import 'auto_cache_manager_config.dart';

import 'core/core.dart';

import 'core/services/compressor/compressor_service.dart';
import 'core/services/cryptography/encrypt/encrypt_cryptography_service.dart';
import 'core/services/cryptography/i_cryptography_service.dart';
import 'core/services/directory_provider/path_provider/path_provider_service.dart';
import 'core/services/storages/prefs/i_prefs_service.dart';
import 'core/services/storages/prefs/shared_preferences/shared_preferences_service.dart';

import 'modules/data_cache/domain/repositories/i_cache_repository.dart';
import 'modules/data_cache/domain/services/invalidation/invalidation_cache_context.dart';
import 'modules/data_cache/domain/usecases/clear_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/delete_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/get_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/save_cache_usecase.dart';

import 'modules/data_cache/external/datasources/prefs_cache_datasource.dart';

import 'modules/data_cache/infra/datasources/i_prefs_cache_datasource.dart';
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
    _registerCacheData();
  }

  Future<void> _registerLibs() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);
  }

  void _registerCore() {
    Injector.I.bindSingleton<CacheConfig>(AutoCacheManagerConfig.instance.config);
    Injector.I.bindSingleton<IPathProviderService>(PathProviderService());
    Injector.I.bindSingleton<ICompressorService>(CompressorService());
    Injector.I.bindSingleton<IPrefsService>(SharedPreferencesService(Injector.I.get()));
    Injector.I.bindSingleton<ICryptographyService>(EncryptCryptographyService(Injector.I.get()));
    Injector.I.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(Injector.I.get()));
  }

  void _registerCacheData() {
    Injector.I.bindFactory<IPrefsCacheDatasource>(() => PrefsCacheDatasource(Injector.I.get(), Injector.I.get()));
    Injector.I.bindFactory<IInvalidationCacheContext>(() => InvalidationCacheContext(Injector.I.get()));
    Injector.I.bindFactory<ICacheRepository>(() => CacheRepository(Injector.I.get(), Injector.I.get()));
    Injector.I.bindFactory<DeleteCacheUsecase>(() => DeleteCache(Injector.I.get()));
    Injector.I.bindFactory<ClearCacheUsecase>(() => ClearCache(Injector.I.get()));
    Injector.I.bindFactory<GetCacheUsecase>(() => GetCache(Injector.I.get(), Injector.I.get()));
    Injector.I.bindFactory<SaveCacheUsecase>(() => SaveCache(Injector.I.get(), Injector.I.get()));
  }
}
