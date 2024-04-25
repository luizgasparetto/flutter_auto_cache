import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/delete_cache_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import 'modules/data_cache/domain/usecases/get_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/save_cache_usecase.dart';
import 'modules/data_cache/external/datasources/prefs_cache_datasource.dart';
import 'modules/data_cache/external/datasources/sql_cache_datasource.dart';
import 'modules/data_cache/infra/datasources/i_prefs_cache_datasource.dart';
import 'modules/data_cache/infra/datasources/i_sql_cache_datasource.dart';
import 'modules/data_cache/infra/repositories/cache_repository.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindSingleton<CacheConfig>(AutoCacheManagerInitializer.I.config);
    Injector.I.bindSingleton<IPathProviderService>(PathProviderService());
    Injector.I.bindSingleton<ICompressorService>(CompressorService());
    Injector.I.bindSingleton<IPrefsService>(SharedPreferencesService(Injector.I.get<SharedPreferences>()));
    Injector.I.bindSingleton<ICryptographyService>(EncryptCryptographyService(Injector.I.get<CacheConfig>()));

    Injector.I.bindFactory<IPrefsCacheDatasource>(() => PrefsCacheDatasource(Injector.I.get<IPrefsService>()));
    Injector.I.bindFactory<ISQLCacheDatasource>(SQLCacheDatasource.new);
    Injector.I.bindFactory<InvalidationCacheContext>(() => InvalidationCacheContext(Injector.I.get<CacheConfig>()));

    Injector.I.bindSingleton<IDirectoryProviderService>(
      DirectoryProviderService(Injector.I.get<IPathProviderService>()),
    );

    Injector.I.bindFactory<ICacheRepository>(
      () => CacheRepository(
        Injector.I.get<IPrefsCacheDatasource>(),
        Injector.I.get<ISQLCacheDatasource>(),
      ),
    );

    Injector.I.bindFactory<GetCacheUsecase>(
      () => GetCache(
        Injector.I.get<ICacheRepository>(),
        Injector.I.get<InvalidationCacheContext>(),
      ),
    );

    Injector.I.bindFactory<SaveCacheUsecase>(
      () => SaveCache(
        Injector.I.get<ICacheRepository>(),
        Injector.I.get<InvalidationCacheContext>(),
      ),
    );

    Injector.I.bindFactory<DeleteCacheUsecase>(
      () => DeleteCache(Injector.I.get<ICacheRepository>()),
    );

    Injector.I.bindFactory<ClearCacheUsecase>(
      () => ClearCache(Injector.I.get<ICacheRepository>()),
    );
  }
}
