import 'package:flutter/foundation.dart';

import '../cache_configuration.dart';

final class CacheConfigurationStore extends ValueNotifier<CacheConfiguration> {
  /// Private constructor for the singleton pattern.
  CacheConfigurationStore._() : super(CacheConfiguration.defaultConfig());

  /// The single instance of [CacheConfiguration].
  static final _instance = CacheConfigurationStore._();

  /// Provides global access to the [CacheConfiguration] instance.
  static CacheConfigurationStore get instance => _instance;

  /// Internally manages the cache configuration, allowing for dynamic updates.
  //final _configListenable = ValueNotifier<CacheConfiguration>(CacheConfiguration.defaultConfig());

  /// Exposes the current cache configuration.
  CacheConfiguration get config => value;

  /// Updates the current cache configuration with a new `CacheConfiguration`.
  ///
  /// - [config]: The new `CacheConfig` to apply.
  void setConfiguration(CacheConfiguration? config) {
    value = config ?? value;
  }
}
