import 'dart:convert';

import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cache_size_service/cache_size_service.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/i_cryptography_service.dart';
import 'package:flutter_auto_cache/src/core/services/kvs_service/i_kvs_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/datasources/query_data_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class KvsServiceMock extends Mock implements IKvsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class CacheSizeServiceMock extends Mock implements ICacheSizeService {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final kvsService = KvsServiceMock();
  final cryptographyService = CryptographyServiceMock();
  final sizeService = CacheSizeServiceMock();

  final sut = QueryDataCacheDatasource(kvsService, cryptographyService, sizeService);

  tearDown(() {
    reset(kvsService);
    reset(cryptographyService);
    reset(sizeService);
  });

  group('QueryDataCacheDatasource.get |', () {
    final createdAt = DateTime.now();
    final endAt = DateTime.now().add(const Duration(hours: 3));

    final successBody = {
      'id': 'key',
      'data': 'my_data',
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
    };

    final stringBody = jsonEncode(successBody);

    test('should be able to find cache data by key successfully', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(stringBody);
      when(() => cryptographyService.decrypt(stringBody)).thenReturn(stringBody);

      final response = sut.get<String>('my_key');

      expect(response, isA<DataCacheEntity<String>>());
      expect(response?.data, equals('my_data'));
      verify(() => kvsService.get(key: 'my_key')).called(1);
    });

    test('should be able to return NULL when not find data in cache', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(null);

      final response = sut.get<String>('my_key');

      expect(response, isNull);
      verify(() => kvsService.get(key: 'my_key')).called(1);
    });

    test('should NOT be able to return data cached when service fails', () {
      when(() => kvsService.get(key: 'my_key')).thenThrow(FakeAutoCacheException());

      expect(() => sut.get<String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.get(key: 'my_key')).called(1);
    });
  });

  group('QueryDataCacheDatasource.getKeys |', () {
    test('should be able to get keys successfully when calls service', () {
      when(() => kvsService.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response, ['keys']);
      verify(() => kvsService.getKeys()).called(1);
    });

    test('should NOT be able to get keys when service fails', () {
      when(() => kvsService.getKeys()).thenThrow(FakeAutoCacheException());

      expect(() => sut.getKeys(), throwsA(isA<AutoCacheException>()));
    });
  });
}
