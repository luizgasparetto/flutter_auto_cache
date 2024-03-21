library auto_cache_manager;

import 'src/modules/cache/presenter/controllers/base_cache_manager_controller.dart';

export 'src/auto_cache_manager_initializer.dart';

class AutoCacheManager {
  static KVSCacheManagerController get kvs => KVSCacheManagerController.instance;
  static SQLCacheManagerController get sql => SQLCacheManagerController.instance;
}
