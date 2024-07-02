import 'package:flutter/foundation.dart';

import '../cache_configuration.dart';

final class CacheConfigurationStore extends ValueNotifier<CacheConfiguration> {
  CacheConfigurationStore._() : super(CacheConfiguration.defaultConfig());

  static final _instance = CacheConfigurationStore._();

  static CacheConfigurationStore get instance => _instance;

  CacheConfiguration get config => value;

  void setConfiguration(CacheConfiguration? config) {
    value = config ?? value;
  }
}
