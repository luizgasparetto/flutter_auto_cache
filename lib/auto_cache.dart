library flutter_auto_cache;

import 'src/modules/data_cache/presenter/controllers/implementations/data_cache_manager_controller.dart';

export 'src/auto_cache_initializer.dart';
export 'src/core/core.dart';
export 'src/modules/data_cache/data_cache.dart';

export 'auto_cache.dart';

/// A utility class for accessing various cache management controllers.
///
/// The `AutoCache` class provides a static property to access the preferences
/// cache manager controller, facilitating the management of cached preferences
/// throughout the application.
class AutoCache {
  /// Provides access to the singleton instance of `PrefsCacheManagerController`.
  ///
  /// This property allows for centralized management of cached preferences.
  static PrefsCacheManagerController get prefs => PrefsCacheManagerController.instance;
}
