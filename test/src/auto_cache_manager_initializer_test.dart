// ignore_for_file: avoid_redundant_argument_values

import 'package:auto_cache_manager/auto_cache_manager_library.dart';
import 'package:auto_cache_manager/src/core/config/base_config.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sut = AutoCacheManagerInitialazer.I;
  const newConfig = BaseConfig(storageType: StorageType.sql, invalidationType: InvalidationType.ttl);

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    sut.setConfig(BaseConfig.defaultConfig());
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
      expect(sut.config.storageType, equals(newConfig.storageType));
    });
  });

  group('AutoCacheManagerInitializer.setConfig |', () {
    test('should be able to verify if initial config is setted', () {
      expect(sut.config.isDefaultConfig, isTrue);
    });

    test('should be able to set a new config for AutoCacheManager', () {
      sut.setConfig(newConfig);

      expect(sut.config.storageType, equals(StorageType.sql));
      expect(sut.config.invalidationType, equals(InvalidationType.ttl));
    });

    test('should NOT be able to set NULL as base config for AutoCacheManager', () {
      sut.setConfig(null);

      expect(sut.config.isDefaultConfig, isTrue);
    });
  });
}
