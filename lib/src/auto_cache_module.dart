import 'core/core_module.dart';
import 'core/infrastructure/modules/cache_module.dart';

import 'modules/data_cache/data_cache_module.dart';

class AutoCacheModule extends CacheModule {
  AutoCacheModule._();

  static final AutoCacheModule _instance = AutoCacheModule._();

  static AutoCacheModule get instance => _instance;

  @override
  Future<void> registerBinds() async {
    await CoreModule.instance.registerBinds();
    await DataCacheModule.instance.registerBinds();
  }
}
