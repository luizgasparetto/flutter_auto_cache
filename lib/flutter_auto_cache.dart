library flutter_auto_cache;

import 'src/modules/data_cache/presenter/controllers/implementations/base_data_cache_controller.dart';

export 'src/auto_cache_initializer.dart';
export 'src/core/core_module.dart' hide CoreModule;
export 'src/modules/data_cache/data_cache_module.dart' hide DataCacheModule;

export 'flutter_auto_cache.dart';

/// A utility class for accessing various cache management controllers.
///
/// The `AutoCache` class provides a static property to access the preferences
/// cache manager controller, facilitating the management of cached preferences
/// throughout the application.
class AutoCache {
  /// Provides access to the singleton instance of `PrefsCacheManagerController`.
  ///
  /// This property allows for centralized management of cached preferences.
  static IDataCacheController get data => DataCacheController.instance;
}
