import 'modules/cache/presenter/controllers/base_cache_manager_controller.dart';

class AutoCacheManager {
  AutoCacheManager._();

  static final AutoCacheManager _instance = AutoCacheManager._();

  static AutoCacheManager get instance => _instance;

  KVSCacheManagerController get kvs => KVSCacheManagerController.instance;
  SQLCacheManagerController get sql => SQLCacheManagerController.instance;
}
