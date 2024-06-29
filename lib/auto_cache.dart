library flutter_auto_cache;

import 'src/modules/data_cache/presenter/controllers/implementations/data_cache_manager_controller.dart';

export 'src/auto_cache_initializer.dart';
export 'src/modules/data_cache/data_cache.dart';

class AutoCache {
  static PrefsCacheManagerController get prefs => PrefsCacheManagerController.instance;
}
