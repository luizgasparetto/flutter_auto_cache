library auto_cache_manager;

import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/value_objects/cache_size_options.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/value_objects/invalidation_methods/implementations/ttl_invalidation_method.dart';

import 'auto_cache_manager.dart';
import 'src/modules/cache/presenter/controllers/base_cache_manager_controller.dart';

export 'src/auto_cache_manager_initializer.dart';

class AutoCacheManager {
  static PrefsCacheManagerController get prefs => PrefsCacheManagerController.instance;
  static SQLCacheManagerController get sql => SQLCacheManagerController.instance;
}

void main() {
  AutoCacheManagerInitializer.I.init(
    config: CacheConfig(
      invalidationMethod: const TTLInvalidationMethod(),
      sizeOptions: const CacheSizeOptions(maxMb: 50),
    ),
  );

  // runApp
}

void getToken() {
  final token = AutoCacheManager.prefs.getString(key: 'token');
}
