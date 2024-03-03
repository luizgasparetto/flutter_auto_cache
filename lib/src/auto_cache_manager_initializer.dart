import 'package:flutter/foundation.dart';

import 'core/core.dart';

class AutoCacheManagerInitialazer {
  AutoCacheManagerInitialazer._();

  static final AutoCacheManagerInitialazer _instance = AutoCacheManagerInitialazer._();

  static AutoCacheManagerInitialazer get instance => _instance;

  final _defaultConfig = ValueNotifier(BaseConfig.defaultConfig());

  bool get isInitialized => Injector.instance.hasBinds;
  BaseConfig get config => _defaultConfig.value;

  Future<void> init({BaseConfig? config}) async {
    await PackageInjections.registerBinds();
    setConfig(config);
  }

  void setConfig(BaseConfig? config) {
    if (config != null) {
      _defaultConfig.value = config;
    }
  }
}
