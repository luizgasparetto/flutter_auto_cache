import 'package:flutter_auto_cache/flutter_auto_cache.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auto_cache/src/core/shared/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/shared/configuration/stores/cache_configuration_store.dart';
import 'package:flutter_auto_cache/src/core/shared/services/service_locator/implementations/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    CacheConfigurationStore.instance.setConfiguration(CacheConfiguration.defaultConfig());
  });

  group('AutoCacheManagerInitializer.initialize |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await AutoCacheInitializer.initialize();

      expect(ServiceLocator.instance.hasBinds, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await AutoCacheInitializer.initialize(configuration: null);

      expect(ServiceLocator.instance.hasBinds, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });
  });
}
