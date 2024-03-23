import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/i_cryptography_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/services/storages/kvs/shared_preferences/shared_preferences_service.dart';
import 'modules/cache/infra/datasources/i_prefs_datasource.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindSingleton<ICryptographyService>(
      CryptographyService(),
    );
    Injector.I.bindSingleton<IPrefsDatasource>(
      SharedPreferencesService(
        Injector.I.get<SharedPreferences>(),
        Injector.I.get<ICryptographyService>(),
      ),
    );
  }
}
