import 'package:auto_cache_manager/auto_cache_manager_library.dart';
import 'package:auto_cache_manager/src/core/config/base_config.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = AutoCacheManagerInitialazer.instance;

  const newConfig = BaseConfig(storageType: StorageType.sql, invalidationType: InvalidationType.ttl);

  tearDown(() {
    sut.setConfig(BaseConfig.defaultConfig());
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
