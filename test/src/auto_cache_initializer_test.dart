// ignore_for_file: avoid_redundant_argument_values
import 'package:auto_cache_manager/auto_cache.dart';
import 'package:auto_cache_manager/src/auto_cache_injections.dart';
import 'package:auto_cache_manager/src/core/configuration/cache_configuration.dart';
import 'package:auto_cache_manager/src/core/configuration/stores/cache_configuration_store.dart';
import 'package:auto_cache_manager/src/core/core.dart';
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
    CacheConfigStore.instance.setConfig(CacheConfig.defaultConfig());
  });

  group('AutoCacheManagerInitializer.init |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await sut.init();

      expect(AutoCacheInjections.instance.isInjectorInitialized, isTrue);
      expect(CacheConfigStore.instance.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await sut.init(config: null);

      expect(AutoCacheInjections.instance.isInjectorInitialized, isTrue);
      expect(CacheConfigStore.instance.config.isDefaultConfig, isTrue);
    });
  });
}
