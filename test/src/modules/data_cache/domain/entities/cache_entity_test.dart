import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCacheEntity extends Fake implements CacheEntity {
  @override
  String get id => 'exclusive_id';
}

void main() {
  final cache = CacheEntity(
    id: 'exclusive_id',
    data: 'data',
    invalidationType: InvalidationType.ttl,
    createdAt: DateTime.now(),
    endAt: DateTime.now(),
  );

  group('CacheEntity.equality |', () {
    final duplicatedCache = cache.copyWith(id: 'exclusive_id');
    final differentId = cache.copyWith(id: 'different_id');

    test('should be able to validate equality of entities using the same id', () {
      expect(cache, equals(duplicatedCache));
      expect(cache.hashCode, equals(duplicatedCache.hashCode));
    });

    test('should NOT be able to validate equality of entities using different ids', () {
      expect(cache, isNot(equals(differentId)));
      expect(cache.hashCode, isNot(equals(differentId.hashCode)));
    });
  });

  group('CacheEntity.toSave |', () {
    final dto = SaveCacheDTO<String>(
      key: 'key',
      data: 'value',
      cacheConfig: CacheConfig(ttlMaxDuration: const Duration(seconds: 30)),
    );

    test('should be able to create a CacheEntity<String> using a SaveCacheDTO', () {
      final response = CacheEntity.toSave(dto);

      expect(response.id, equals('key'));
      expect(response.data, equals('value'));
      expect(response.invalidationType, equals(InvalidationType.ttl));
      expect(response.endAt.isAfter(DateTime.now()), isTrue);
    });
  });
}
