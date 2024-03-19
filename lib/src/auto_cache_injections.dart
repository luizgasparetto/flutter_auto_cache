import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/services/storages/kvs/shared_preferences/shared_preferences_kvs_service.dart';

import 'modules/cache/infra/datasources/i_key_value_storage_datasource.dart';

class AutoCacheInjections {
  static Future<void> registerBinds() async {
    await Injector.I.asyncBind(SharedPreferences.getInstance);

    Injector.I.bindSingleton<IKeyValueStorageDatasource>(
      SharedPreferencesKeyValueStorageService(
        Injector.I.get<SharedPreferences>(),
      ),
    );
  }
}
