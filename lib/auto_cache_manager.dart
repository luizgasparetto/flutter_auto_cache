library auto_cache_manager;

import 'auto_cache_manager.dart';
import 'src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';

export 'src/auto_cache_manager_initializer.dart';

class AutoCacheManager {
  static PrefsCacheManagerController get prefs => PrefsCacheManagerController.instance;
  static SQLCacheManagerController get sql => SQLCacheManagerController.instance;
}

void main() async {
  await AutoCacheManagerInitializer.instance.init();
}
