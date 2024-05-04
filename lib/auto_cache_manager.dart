library auto_cache_manager;

import 'package:auto_cache_manager/src/core/middlewares/init_middleware.dart';

import 'src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';

export 'src/auto_cache_manager_initializer.dart';

class AutoCacheManager {
  static PrefsCacheManagerController get prefs => InitMiddleware.accessInstance(PrefsCacheManagerController.instance);
  static SQLCacheManagerController get sql => InitMiddleware.accessInstance(SQLCacheManagerController.instance);
}
