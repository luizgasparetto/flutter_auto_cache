import 'core/core_module.dart';

import 'core/shared/contracts/modules/package_module.dart';

import 'modules/data_cache/data_cache_module.dart';
import 'modules/file_cache/file_cache_module.dart';

class AutoCacheModule extends PackageModule {
  AutoCacheModule._();

  static final AutoCacheModule _instance = AutoCacheModule._();

  static AutoCacheModule get instance => _instance;

  @override
  List<CacheModule> get modules => [CoreModule(), DataCacheModule(), FileCacheModule()];
}
