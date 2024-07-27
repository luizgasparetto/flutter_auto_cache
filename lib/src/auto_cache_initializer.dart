import 'auto_cache_module.dart';

import 'core/shared/configuration/cache_configuration.dart';
import 'core/shared/configuration/stores/cache_configuration_store.dart';

/// A singleton class responsible for initializing and configuring the auto cache manager.
/// It provides a central point of access to manage cache configurations and ensures
/// that the cache injection mechanism is properly set up before use.
class AutoCacheInitializer {
  /// Initializes the cache management system with optional custom configuration.
  /// This method sets up necessary bindings and applies the provided `CacheConfig`.
  ///
  /// - [config]: An optional `CacheConfiguration` to customize cache behavior.
  static Future<void> initialize({CacheConfiguration? configuration}) async {
    CacheConfigurationStore.instance.setConfiguration(configuration);
    await AutoCacheModule.instance.initialize();
  }
}
