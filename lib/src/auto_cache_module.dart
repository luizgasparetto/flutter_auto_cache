import 'core/core_module.dart';

import 'core/infrastructure/contracts/module_contracts.dart';
import 'modules/data_cache/data_cache_module.dart';

class AutoCacheModule extends PackageModule {
  AutoCacheModule._();

  static final AutoCacheModule _instance = AutoCacheModule._();

  static AutoCacheModule get instance => _instance;

  @override
  List<CacheModule> get modules => [CoreModule(), DataCacheModule()];
}
