import 'modules/cache/presenter/controllers/base_cache_manager_controller.dart';

class AutoCacheManager {
  static KVSCacheManagerController get kvs => KVSCacheManagerController.instance;
  static SQLCacheManagerController get sql => SQLCacheManagerController.instance;
}
