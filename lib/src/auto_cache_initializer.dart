import 'auto_cache_injections.dart';

import 'core/core.dart';
import 'core/configuration/stores/cache_configuration_store.dart';

/// A singleton class responsible for initializing and configuring the auto cache manager.
/// It provides a central point of access to manage cache configurations and ensures
/// that the cache injection mechanism is properly set up before use.
class AutoCacheInitializer {
  AutoCacheInitializer._();

  static final _instance = AutoCacheInitializer._();

  static AutoCacheInitializer get instance => _instance;

  /// Initializes the cache management system with optional custom configuration.
  /// This method sets up necessary bindings and applies the provided `CacheConfig`.
  ///
  /// - [config]: An optional `CacheConfiguration` to customize cache behavior.
  Future<void> init({CacheConfiguration? configuration}) async {
    CacheConfigurationStore.instance.setConfiguration(configuration);
    await AutoCacheInjections.instance.registerBinds();
  }
}
