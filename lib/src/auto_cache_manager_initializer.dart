import 'package:flutter/foundation.dart';

import 'core/core.dart';

class AutoCacheManagerInitialazer {
  AutoCacheManagerInitialazer._();

  static final AutoCacheManagerInitialazer _instance = AutoCacheManagerInitialazer._();

  static AutoCacheManagerInitialazer get I => _instance;

  final _configListenable = ValueNotifier(CacheConfig.defaultConfig());

  bool get isInjectorInitialized => Injector.I.hasBinds;
  CacheConfig get config => _configListenable.value;

  Future<void> init({CacheConfig? config}) async {
    await PackageInjections.registerBinds();
    setConfig(config);
  }

  void setConfig(CacheConfig? config) {
    if (config != null) {
      _configListenable.value = config;
    }
  }
}
