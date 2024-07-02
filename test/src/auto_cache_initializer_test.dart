import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/auto_cache_injections.dart';
import 'package:flutter_auto_cache/src/core/configuration/stores/cache_configuration_store.dart';

import 'package:flutter/material.dart';
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

  group('AutoCacheManagerInitializer.init |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await AutoCacheInitializer.init();

      expect(AutoCacheInjections.isInjectorInitialized, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await AutoCacheInitializer.init(configuration: null);

      expect(AutoCacheInjections.isInjectorInitialized, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });
  });
}
