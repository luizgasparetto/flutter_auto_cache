import 'package:flutter_auto_cache/src/core/domain/value_objects/cache_metadata.dart';
import 'package:flutter_auto_cache/src/core/shared/extensions/types/map_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/exceptions/data_cache_adapter_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/data_cache_adapter.dart';

void main() {
  const id = 'dev';
  const data = 'test';
  final createdAt = DateTime.now();
  final updatedAt = DateTime.now();
  final endAt = createdAt.add(const Duration(days: 3));
  final usedAt = createdAt.add(const Duration(days: 1));

  group('DataCacheAdapter.fromJson |', () {
    final jsonCache = <String, dynamic>{
      'id': id,
      'data': data,
      'usage_count': 0,
      'metadata': {
        'created_at': createdAt.toIso8601String(),
        'end_at': endAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'used_at': usedAt.toIso8601String(),
      }
    };

    test('should be able to get DataCacheEntity from json successfully', () {
      final cache = DataCacheAdapter.fromJson<String>(jsonCache);

      expect(cache.id, equals(id));
      expect(cache.data, equals(data));
      expect(cache.usageCount, equals(0));
      expect(cache.metadata.createdAt, equals(createdAt));
      expect(cache.metadata.endAt, equals(endAt));
      expect(cache.metadata.updatedAt, equals(updatedAt));
      expect(cache.metadata.usedAt, equals(usedAt));
    });

    test('should NOT be able to get DataCacheEntity from json when invalid keys', () {
      final jsonInvalidKeys = jsonCache.updateKey(oldKey: 'metadata', newKey: 'invalid_created_at');

      expect(() => DataCacheAdapter.fromJson<String>(jsonInvalidKeys), throwsA(isA<DataCacheFromJsonException>()));
    });
  });

  group('DataCacheAdapter.listFromJson |', () {
    final listData = ['data', 'data', 'data', 'data'];

    final listJson = <String, dynamic>{
      'id': id,
      'data': listData,
      'usage_count': 0,
      'metadata': {
        'created_at': createdAt.toIso8601String(),
        'end_at': endAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'used_at': usedAt.toIso8601String(),
      }
    };

    test('should be able to serialize JSON into a DataCacheEntity with List as data content', () {
      final response = DataCacheAdapter.listFromJson<List<String>, String>(listJson);

      expect(response.id, equals(id));
      expect(response.data, equals(listData));
      expect(response.data, isA<List<String>>());
      expect(response.usageCount, equals(0));
      expect(response.metadata.createdAt, equals(createdAt));
      expect(response.metadata.endAt, equals(endAt));
      expect(response.metadata.updatedAt, equals(updatedAt));
      expect(response.metadata.usedAt, equals(usedAt));
    });

    test('should NOT be able to get DataCacheEntity from json with data list when has invalid values', () {
      final invalidJson = listJson.updateValueByKey(key: 'metadata', newValue: 'invalid_value');

      expect(() => DataCacheAdapter.listFromJson<List<String>, String>(invalidJson), throwsA(isA<DataCacheListFromJsonException>()));
    });

    test('should NOT be able to get DataCacheEntity from json with data list when has invalid keys', () {
      final invalidJson = listJson.updateValueByKey(key: 'metadata', newValue: 'invalid_value');

      expect(() => DataCacheAdapter.listFromJson<List<String>, String>(invalidJson), throwsA(isA<DataCacheListFromJsonException>()));
    });
  });

  group('DataCacheAdapter.toJson |', () {
    final cache = DataCacheEntity(
      id: id,
      data: data,
      metadata: CacheMetadata(
        createdAt: createdAt,
        endAt: endAt,
        updatedAt: updatedAt,
        usedAt: usedAt,
      ),
    );

    test('should be able to parse DataCacheEntity to json and verify keys', () {
      final jsonCache = DataCacheAdapter.toJson(cache);

      expect(jsonCache.containsKey('id'), isTrue);
      expect(jsonCache.containsKey('data'), isTrue);
      expect(jsonCache.containsKey('usage_count'), isTrue);
      expect(jsonCache.containsKey('metadata'), isTrue);
    });

    test('should be able to parse DataCacheEntity to json and verify values', () {
      final jsonCache = DataCacheAdapter.toJson(cache);

      expect(jsonCache['id'], equals(id));
      expect(jsonCache['data'], equals(data));
      expect(jsonCache['usage_count'], equals(0));
      expect(jsonCache['metadata']['created_at'], equals(createdAt.toIso8601String()));
      expect(jsonCache['metadata']['end_at'], equals(endAt.toIso8601String()));
      expect(jsonCache['metadata']['updated_at'], equals(updatedAt.toIso8601String()));
      expect(jsonCache['metadata']['used_at'], equals(usedAt.toIso8601String()));
    });
  });
}
