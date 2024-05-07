library auto_cache_manager;

import 'src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';

export 'src/auto_cache_manager_initializer.dart';
export 'src/modules/data_cache/data_cache.dart';

class AutoCacheManager {
  static PrefsCacheManagerController get prefs => PrefsCacheManagerController.instance;
}
