// ignore_for_file: avoid_redundant_argument_values
import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/auto_cache_injections.dart';
import 'package:auto_cache_manager/src/auto_cache_manager_config.dart';
import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sut = AutoCacheManagerInitializer.instance;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    AutoCacheManagerConfig.instance.setConfig(CacheConfig.defaultConfig());
  });

  group('AutoCacheManagerInitializer.init |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await sut.init();

      expect(AutoCacheInjections.isInjectorInitialized, isTrue);
      expect(AutoCacheManagerConfig.instance.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await sut.init(config: null);

      expect(AutoCacheInjections.isInjectorInitialized, isTrue);
      expect(AutoCacheManagerConfig.instance.config.isDefaultConfig, isTrue);
    });
  });
}
