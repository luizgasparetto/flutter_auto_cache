import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/services/storages/kvs/shared_preferences/shared_preferences_service.dart';
import 'modules/cache/infra/datasources/i_prefs_datasource.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindSingleton<IPrefsDatasource>(
      SharedPreferencesService(
        Injector.I.get<SharedPreferences>(),
      ),
    );
  }
}
