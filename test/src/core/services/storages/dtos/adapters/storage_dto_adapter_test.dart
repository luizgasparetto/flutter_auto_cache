import 'package:auto_cache_manager/src/core/services/storages/dtos/adapters/storage_dto_adapter.dart';
import 'package:auto_cache_manager/src/core/services/storages/dtos/storage_dto.dart';
import 'package:auto_cache_manager/src/core/services/storages/exceptions/adapters_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  final isoDate = DateTime.now().toIso8601String();

  group('StorageDTOAdapter.fromJson |', () {
    final successBody = {
      'id': 'id',
      'data': 'data_string',
      'invalidation_type_code': 'ttl',
      'created_at': isoDate,
    };

    final invalidKeysBody = {
      'error_id': 'id',
      'error_data': 'data_string',
      'error_invalidation_type_code': 'ttl',
      'error_created_at': isoDate,
    };

    final invalidDataBody = {
      'id': 'id',
      'data': [1, 2, 3, 4, 5],
      'invalidation_type_code': 'ttl',
      'created_at': isoDate,
    };

    test('should be able to parse a Map<String, dynamic> into a StorageDTO successfully', () {
      final response = StorageDTOAdapter.fromJson<String>(successBody);

      expect(response.id, equals('id'));
      expect(response.data.runtimeType, equals(String));
      expect(response.data, equals('data_string'));
      expect(response.invalidationTypeCode, equals('ttl'));
      expect(response.createdAt, equals(DateTime.parse(isoDate)));
    });

    test('should NOT be able to parse a Map<String, dynamic> when keys are invalid', () {
      expect(
        () => StorageDTOAdapter.fromJson<String>(invalidKeysBody),
        throwsA(isA<StorageAdapterException>()),
      );
    });

    test('should NOT be able to parse an Map<String, dynamic> when T is different from data type', () {
      expect(
        () => StorageDTOAdapter.fromJson<String>(invalidDataBody),
        throwsA(isA<StorageAdapterException>()),
      );
    });
  });

  group('StorageDTOAdapter.toJson |', () {
    final dto = StorageDTO<String>(
      id: 'id',
      data: 'data_cache',
      invalidationTypeCode: 'ttl',
      createdAt: now,
    );

    test('should be able to parse a StorageDTO into a Map<String, dynamic> and validate keys', () {
      final response = StorageDTOAdapter.toJson(dto);

      expect(response.containsKey('id'), isTrue);
      expect(response.containsKey('data'), isTrue);
      expect(response.containsKey('invalidation_type_code'), isTrue);
      expect(response.containsKey('created_at'), isTrue);
    });

    test('should be able to parse a StorageDTO into a Map<String, dynamic> and validate values', () {
      final response = StorageDTOAdapter.toJson(dto);

      expect(response['id'], equals('id'));
      expect(response['data'], equals('data_cache'));
      expect(response['invalidation_type_code'], equals('ttl'));
      expect(response['created_at'], equals(now.toIso8601String()));
    });
  });
}
