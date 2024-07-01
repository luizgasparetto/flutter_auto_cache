import 'package:flutter/foundation.dart';

import '../cache_config.dart';

final class CacheConfigStore extends ValueNotifier<CacheConfig> {
  /// Private constructor for the singleton pattern.
  CacheConfigStore._() : super(CacheConfig.defaultConfig());

  /// The single instance of [CacheConfigStore].
  static final _instance = CacheConfigStore._();

  /// Provides global access to the [AutoCacheManagerConfig] instance.
  static CacheConfigStore get instance => _instance;

  /// Internally manages the cache configuration, allowing for dynamic updates.
  //final _configListenable = ValueNotifier<CacheConfig>(CacheConfig.defaultConfig());

  /// Exposes the current cache configuration.
  CacheConfig get config => value;

  /// Updates the current cache configuration with a new `CacheConfig`.
  ///
  /// - [config]: The new `CacheConfig` to apply.
  void setConfig(CacheConfig? config) {
    value = config ?? value;
  }
}
