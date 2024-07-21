import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/exceptions/data_cache_adapter_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auto_cache/src/core/extensions/types/map_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/data_cache_adapter.dart';

void main() {
  const id = 'dev';
  const data = 'test';
  final createdAt = DateTime.now();
  final updatedAt = DateTime.now();
  final endAt = createdAt.add(const Duration(days: 3));

  group('DataCacheAdapter.fromJson |', () {
    final jsonCache = <String, dynamic>{
      'id': id,
      'data': data,
      'usage_count': 0,
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };

    test('should be able to get DataCacheEntity from json successfully', () {
      final cache = DataCacheAdapter.fromJson<String>(jsonCache);

      expect(cache.id, equals(id));
      expect(cache.data, equals(data));
      expect(cache.usageCount, equals(0));
      expect(cache.createdAt, equals(createdAt));
      expect(cache.endAt, equals(endAt));
      expect(cache.updatedAt, equals(updatedAt));
    });

    test('should NOT be able to get DataCacheEntity from json when invalid values', () {
      final invalidJson = jsonCache.updateValueByKey(key: 'created_at', newValue: 'invalid_value');

      expect(() => DataCacheAdapter.fromJson(invalidJson), throwsA(isA<DataCacheFromJsonException>()));
    });

    test('should NOT be able to get DataCacheEntity from json when invalid keys', () {
      final jsonInvalidKeys = jsonCache.updateKey(oldKey: 'created_at', newKey: 'invalid_created_at');

      expect(() => DataCacheAdapter.fromJson<String>(jsonInvalidKeys), throwsA(isA<DataCacheFromJsonException>()));
    });
  });

  group('DataCacheAdapter.listFromJson |', () {
    final listData = ['data', 'data', 'data', 'data'];

    final listJson = <String, dynamic>{
      'id': id,
      'data': listData,
      'usage_count': 0,
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };

    test('should be able to serialize JSON into a DataCacheEntity with List as data content', () {
      final response = DataCacheAdapter.listFromJson<List<String>, String>(listJson);

      expect(response.id, equals(id));
      expect(response.data, equals(listData));
      expect(response.data, isA<List<String>>());
      expect(response.usageCount, equals(0));
      expect(response.createdAt, equals(createdAt));
      expect(response.endAt, equals(endAt));
      expect(response.updatedAt, equals(updatedAt));
    });

    test('should NOT be able to get DataCacheEntity from json with data list when has invalid values', () {
      final invalidJson = listJson.updateValueByKey(key: 'created_at', newValue: 'invalid_value');

      expect(() => DataCacheAdapter.listFromJson<List<String>, String>(invalidJson), throwsA(isA<DataCacheListFromJsonException>()));
    });

    test('should NOT be able to get DataCacheEntity from json with data list when has invalid keys', () {
      final invalidJson = listJson.updateValueByKey(key: 'created_at', newValue: 'invalid_value');

      expect(() => DataCacheAdapter.listFromJson<List<String>, String>(invalidJson), throwsA(isA<DataCacheListFromJsonException>()));
    });
  });

  group('DataCacheAdapter.toJson |', () {
    final cache = DataCacheEntity(id: id, data: data, createdAt: createdAt, endAt: endAt, updatedAt: updatedAt);

    test('should be able to parse DataCacheEntity to json and verify keys', () {
      final jsonCache = DataCacheAdapter.toJson(cache);

      expect(jsonCache.containsKey('id'), isTrue);
      expect(jsonCache.containsKey('data'), isTrue);
      expect(jsonCache.containsKey('usage_count'), isTrue);
      expect(jsonCache.containsKey('created_at'), isTrue);
      expect(jsonCache.containsKey('end_at'), isTrue);
      expect(jsonCache.containsKey('updated_at'), isTrue);
    });

    test('should be able to parse DataCacheEntity to json and verify values', () {
      final jsonCache = DataCacheAdapter.toJson(cache);

      expect(jsonCache['id'], equals(id));
      expect(jsonCache['data'], equals(data));
      expect(jsonCache['usage_count'], equals(0));
      expect(jsonCache['created_at'], equals(createdAt.toIso8601String()));
      expect(jsonCache['end_at'], equals(endAt.toIso8601String()));
      expect(jsonCache['updated_at'], equals(updatedAt.toIso8601String()));
    });
  });
}
