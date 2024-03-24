// ignore_for_file: avoid_redundant_argument_values

import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/value_objects/cache_size_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sut = AutoCacheManagerInitializer.I;
  final newConfig = CacheConfig(invalidationType: InvalidationType.ttl);

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    sut.setConfig(CacheConfig.defaultConfig());
  });

  group('AutoCacheManagerInitializer.init |', () {
    test('should be able to init AutoCacheManagerInitializer with base config', () async {
      await sut.init();

      expect(sut.isInjectorInitialized, isTrue);
      expect(sut.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with base config, even passing NULL', () async {
      await sut.init(config: null);

      expect(sut.isInjectorInitialized, isTrue);
      expect(sut.config.isDefaultConfig, isTrue);
    });

    test('should be able to init AutoCacheManagerInitializer with different config', () async {
      await sut.init(config: newConfig);

      expect(sut.isInjectorInitialized, isTrue);
      expect(sut.config.isDefaultConfig, false);
      expect(sut.config.invalidationType, equals(newConfig.invalidationType));
      expect(sut.config.sizeOptions, equals(CacheSizeOptions.createDefault()));
    });
  });
}
