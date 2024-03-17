import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final initialized = AutoCacheManagerInitialazer.I;

  group('SaveCacheDTO.withConfig |', () {
    const config = CacheConfig(storageType: StorageType.sql, invalidationType: InvalidationType.ttl);

    test('should be able to create a SaveCacheDTO with config settings', () {
      initialized.setConfig(config);

      final sut = SaveCacheDTO<String>.withConfig(key: 'any_key', data: 'any_data');

      expect(sut.storageType, equals(StorageType.sql));
      expect(sut.invalidationType, equals(InvalidationType.ttl));
    });
  });
}
