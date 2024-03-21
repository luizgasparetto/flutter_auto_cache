import 'package:flutter/material.dart';

import 'auto_cache_injections.dart';
import 'core/core.dart';

/// A singleton class responsible for initializing and configuring the auto cache manager.
/// It provides a central point of access to manage cache configurations and ensures
/// that the cache injection mechanism is properly set up before use.
class AutoCacheManagerInitializer {
  /// Private constructor for the singleton pattern.
  AutoCacheManagerInitializer._();

  /// The single instance of [AutoCacheManagerInitializer].
  static final AutoCacheManagerInitializer _instance = AutoCacheManagerInitializer._();

  /// Provides global access to the [AutoCacheManagerInitializer] instance.
  static AutoCacheManagerInitializer get I => _instance;

  /// Internally manages the cache configuration, allowing for dynamic updates.
  final _configListenable = ValueNotifier<CacheConfig>(CacheConfig.defaultConfig());

  /// Indicates whether the `Injector` for cache management is initialized.
  bool get isInjectorInitialized => Injector.I.hasBinds;

  /// Exposes the current cache configuration.
  CacheConfig get config => _configListenable.value;

  /// Initializes the cache management system with optional custom configuration.
  /// This method sets up necessary bindings and applies the provided `CacheConfig`.
  ///
  /// - [config]: An optional `CacheConfig` to customize cache behavior.
  Future<void> init({CacheConfig? config}) async {
    await AutoCacheInjections.registerBinds();
    setConfig(config ?? this.config);
  }

  /// Updates the current cache configuration with a new `CacheConfig`.
  ///
  /// - [config]: The new `CacheConfig` to apply.
  void setConfig(CacheConfig config) {
    _configListenable.value = config;
  }
}
