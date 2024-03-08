import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/cache_adapter.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/enums/invalidation_type_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheAdapter.fromJson |', () {
    test('should be able to get CacheEntity from json successfully', () async {
      // Arrange
      const id = 'zanelladev';
      const data = 'test';
      const storageType = StorageType.kvs;
      const invalidationType = InvalidationType.ttl;
      final createAt = DateTime.utc(2024, 9, 9);

      final jsonCache = {
        'id': id,
        'data': data,
        'storage_type': storageType.name,
        'invalidation_type': InvalidationTypeAdapter.toKey(invalidationType),
        'created_at': createAt.toIso8601String(),
      };

      // Act
      final cache = CacheAdapter.fromJson(
        jsonCache,
        storageType: StorageType.kvs,
      );

      // // Assert
      expect(cache.id, equals(id));
      expect(cache.data, equals(data));
      expect(cache.storageType, equals(storageType));
      expect(cache.invalidationType, equals(invalidationType));
      expect(cache.createdAt, equals(createAt));
    });
  });

  group('CacheAdapter.toJson |', () {
    test('should be able to parse CacheEntity to json successfully', () async {
      // Arrange
      const id = 'zanelladev';
      const data = 'test';
      const storageType = StorageType.kvs;
      const invalidationType = InvalidationType.ttl;
      final createAt = DateTime.utc(2024, 9, 9);

      final cache = CacheEntity(
        id: id,
        data: data,
        storageType: storageType,
        invalidationType: invalidationType,
        createdAt: createAt,
      );

      // Act
      final jsonCache = CacheAdapter.toJson(cache);

      // Assert
      expect(jsonCache['id'], equals(id));
      expect(jsonCache['data'], equals(data));
      expect(jsonCache['storage_type'], isNull);
      expect(jsonCache['invalidation_type'], equals(InvalidationTypeAdapter.toKey(invalidationType)));
      expect(jsonCache['created_at'], equals(createAt.toIso8601String()));
    });
  });
}
