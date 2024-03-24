import 'package:auto_cache_manager/auto_cache_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/services/storages/kvs/i_prefs_service.dart';
import 'core/services/storages/kvs/shared_preferences/shared_preferences_service.dart';
import 'modules/cache/domain/repositories/i_cache_repository.dart';
import 'modules/cache/external/datasources/prefs_cache_datasource.dart';
import 'modules/cache/external/datasources/sql_cache_datasource.dart';
import 'modules/cache/infra/datasources/i_prefs_cache_datasource.dart';
import 'modules/cache/infra/datasources/i_sql_cache_datasource.dart';
import 'modules/cache/infra/repositories/cache_repository.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindInstance<CacheConfig>(AutoCacheManagerInitializer.I.config);
    Injector.I.bindSingleton<IPrefsService>(SharedPreferencesService(Injector.I.get<SharedPreferences>()));

    Injector.I.bindFactory<IPrefsCacheDatasource>(() => PrefsCacheDatasource(Injector.I.get<IPrefsService>()));
    Injector.I.bindFactory<ISQLCacheDatasource>(SQLCacheDatasource.new);

    Injector.I.bindFactory<ICacheRepository>(
      () => CacheRepository(Injector.I.get<IPrefsCacheDatasource>(), Injector.I.get<ISQLCacheDatasource>()),
    );
  }
}
