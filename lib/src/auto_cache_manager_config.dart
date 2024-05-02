import 'package:flutter/foundation.dart';

import 'core/core.dart';

class AutoCacheManagerConfig {
  /// Private constructor for the singleton pattern.
  AutoCacheManagerConfig._();

  /// The single instance of [AutoCacheManagerConfig].
  static final _instance = AutoCacheManagerConfig._();

  /// Provides global access to the [AutoCacheManagerConfig] instance.
  static AutoCacheManagerConfig get instance => _instance;

  /// Internally manages the cache configuration, allowing for dynamic updates.
  final _configListenable = ValueNotifier<CacheConfig>(CacheConfig.defaultConfig());

  /// Exposes the current cache configuration.
  CacheConfig get config => _configListenable.value;

  /// Updates the current cache configuration with a new `CacheConfig`.
  ///
  /// - [config]: The new `CacheConfig` to apply.
  void setConfig(CacheConfig? config) {
    _configListenable.value = config ?? _configListenable.value;
  }
}
