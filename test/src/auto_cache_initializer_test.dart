import 'package:flutter_auto_cache/auto_cache.dart';
import 'package:flutter_auto_cache/src/auto_cache_injections.dart';
import 'package:flutter_auto_cache/src/core/configuration/stores/cache_configuration_store.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sut = AutoCacheInitializer.instance;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    CacheConfigurationStore.instance.setConfiguration(CacheConfiguration.defaultConfig());
  });

  group('AutoCacheManagerInitializer.init |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await sut.init();

      expect(AutoCacheInjections.instance.isInjectorInitialized, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await sut.init(configuration: null);

      expect(AutoCacheInjections.instance.isInjectorInitialized, isTrue);
      expect(CacheConfigurationStore.instance.config.isDefaultConfig, isTrue);
    });
  });
}
