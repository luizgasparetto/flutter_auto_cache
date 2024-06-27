import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auto_cache/src/core/extensions/map_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/cache_adapter.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/enums/invalidation_type_adapter.dart';

void main() {
  const id = 'zanelladev';
  const data = 'test';
  const invalidationType = InvalidationType.ttl;
  final createdAt = DateTime.now();
  final endAt = createdAt.add(const Duration(days: 3));

  group('CacheAdapter.fromJson |', () {
    final jsonCache = {
      'id': id,
      'data': data,
      'invalidation_type': InvalidationTypeAdapter.toKey(invalidationType),
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String()
    };

    // test('should be able to get CacheEntity from json successfully', () {
    //   final cache = CacheAdapter.fromJson<String>(jsonCache);

    //   expect(cache.id, equals(id));
    //   expect(cache.data, equals(data));
    //   expect(cache.invalidationType, equals(invalidationType));
    //   expect(cache.createdAt, equals(createdAt));
    //   expect(cache.endAt, equals(endAt));
    // });

    test('should NOT be able to get CacheEntity from json when invalid values', () {
      final invalidJson = jsonCache.updateValueByKey(key: 'created_at', newValue: 'invalid_value');

      expect(() => CacheAdapter.fromJson(invalidJson), throwsFormatException);
    });

    test('should NOT be able to get CacheEntity from json when invalid keys', () {
      final jsonInvalidKeys = jsonCache.updateKey(oldKey: 'created_at', newKey: 'invalid_created_at');

      expect(() => CacheAdapter.fromJson(jsonInvalidKeys), throwsA(isA<TypeError>()));
    });
  });

  group('CacheAdapter.toJson |', () {
    final cache = CacheEntity(
      id: id,
      data: data,
      invalidationType: invalidationType,
      createdAt: createdAt,
      endAt: endAt,
    );

    test('should be able to parse CacheEntity to json and verify keys', () {
      final jsonCache = CacheAdapter.toJson(cache);

      expect(jsonCache.containsKey('id'), isTrue);
      expect(jsonCache.containsKey('data'), isTrue);
      expect(jsonCache.containsKey('invalidation_type'), isTrue);
      expect(jsonCache.containsKey('created_at'), isTrue);
      expect(jsonCache.containsKey('end_at'), isTrue);
    });

    test('should be able to parse CacheEntity to json and verify values', () {
      final jsonCache = CacheAdapter.toJson(cache);

      expect(jsonCache['id'], equals(id));
      expect(jsonCache['data'], equals(data));
      expect(jsonCache['invalidation_type'], equals(InvalidationTypeAdapter.toKey(invalidationType)));
      expect(jsonCache['created_at'], equals(createdAt.toIso8601String()));
      expect(jsonCache['end_at'], equals(endAt.toIso8601String()));
    });
  });
}
