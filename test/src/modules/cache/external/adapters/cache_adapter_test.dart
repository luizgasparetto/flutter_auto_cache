// ignore_for_file: require_trailing_commas

import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/cache_adapter.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/enums/invalidation_type_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = 'zanelladev';
  const data = 'test';
  const storageType = StorageType.kvs;
  const invalidationType = InvalidationType.ttl;
  final createAt = DateTime.utc(2024, 9, 9);

  group('CacheAdapter.fromJson |', () {
    test('should be able to get CacheEntity from json successfully', () {
      final jsonCache = {
        'id': id,
        'data': data,
        'storage_type': storageType.name,
        'invalidation_type': InvalidationTypeAdapter.toKey(invalidationType),
        'created_at': createAt.toIso8601String(),
      };

      final cache = CacheAdapter.fromJson(jsonCache);

      expect(cache.id, equals(id));
      expect(cache.data, equals(data));
      expect(cache.invalidationType, equals(invalidationType));
      expect(cache.createdAt, equals(createAt));
    });

    test('should NOT be able to get CacheEntity from json when invalid values', () {
      final jsonCache = {
        'id': id,
        'data': data,
        'storage_type': storageType.name,
        'invalidation_type': InvalidationTypeAdapter.toKey(invalidationType),
        'created_at': 'error value @zanelladev',
      };

      expect(() => CacheAdapter.fromJson(jsonCache), throwsFormatException);
    });

    test('should NOT be able to get CacheEntity from json when invalid keys', () {
      final jsonCache = {
        'invalidkey': id,
        'data': data,
        'storage_type': storageType.name,
        'invalidation_type': InvalidationTypeAdapter.toKey(invalidationType),
        'created_at': createAt.toIso8601String(),
      };

      expect(() => CacheAdapter.fromJson(jsonCache), throwsA(isA<TypeError>()));
    });
  });

  group('CacheAdapter.toJson |', () {
    test('should be able to parse CacheEntity to json successfully', () {
      final cache = CacheEntity(
        id: id,
        data: data,
        invalidationType: invalidationType,
        createdAt: createAt,
      );

      final jsonCache = CacheAdapter.toJson(cache);

      expect(jsonCache.containsKey('id'), isTrue);
      expect(jsonCache['id'], equals(id));

      expect(jsonCache.containsKey('data'), isTrue);
      expect(jsonCache['data'], equals(data));

      expect(jsonCache.containsKey('invalidation_type'), isTrue);
      expect(jsonCache['invalidation_type'], equals(InvalidationTypeAdapter.toKey(invalidationType)));

      expect(jsonCache.containsKey('created_at'), isTrue);
      expect(jsonCache['created_at'], equals(createAt.toIso8601String()));
    });
  });
}
