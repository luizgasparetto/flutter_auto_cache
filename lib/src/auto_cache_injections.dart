import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/services/directory_provider/path_provider/path_provider_service.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/clear_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/save_cache_usecase.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/services/storages/prefs/i_prefs_service.dart';
import 'core/services/storages/prefs/shared_preferences/shared_preferences_service.dart';
import 'modules/cache/domain/repositories/i_cache_repository.dart';
import 'modules/cache/domain/services/invalidation/invalidation_cache_context.dart';
import 'modules/cache/external/datasources/prefs_cache_datasource.dart';
import 'modules/cache/external/datasources/sql_cache_datasource.dart';
import 'modules/cache/infra/datasources/i_prefs_cache_datasource.dart';
import 'modules/cache/infra/datasources/i_sql_cache_datasource.dart';
import 'modules/cache/infra/repositories/cache_repository.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindSingleton<IPathProviderService>(PathProviderService());

    Injector.I.bindSingleton<IDirectoryProviderService>(
      DirectoryProviderService(Injector.I.get<IPathProviderService>()),
    );

    Injector.I.bindSingleton<CacheConfig>(AutoCacheManagerInitializer.I.config);
    Injector.I.bindSingleton<IPrefsService>(SharedPreferencesService(Injector.I.get<SharedPreferences>()));

    Injector.I.bindFactory<IPrefsCacheDatasource>(() => PrefsCacheDatasource(Injector.I.get<IPrefsService>()));
    Injector.I.bindFactory<ISQLCacheDatasource>(SQLCacheDatasource.new);

    Injector.I.bindFactory<InvalidationCacheContext>(() => InvalidationCacheContext(Injector.I.get<CacheConfig>()));

    Injector.I.bindFactory<ICacheRepository>(
      () => CacheRepository(Injector.I.get<IPrefsCacheDatasource>(), Injector.I.get<ISQLCacheDatasource>()),
    );

    Injector.I.bindFactory<GetCacheUsecase>(
      () => GetCache(Injector.I.get<ICacheRepository>(), Injector.I.get<InvalidationCacheContext>()),
    );

    Injector.I.bindFactory<SaveCacheUsecase>(
      () => SaveCache(Injector.I.get<ICacheRepository>(), Injector.I.get<InvalidationCacheContext>()),
    );

    Injector.I.bindFactory<ClearCacheUsecase>(() => ClearCache(Injector.I.get<ICacheRepository>()));
  }
}
