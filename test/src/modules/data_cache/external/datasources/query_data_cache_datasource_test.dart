import 'dart:convert';

import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
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

  final createdAt = DateTime.now();
  final endAt = DateTime.now().add(const Duration(hours: 3));

  tearDown(() {
    reset(kvsService);
    reset(cryptographyService);
    reset(sizeService);
  });

  group('QueryDataCacheDatasource.get |', () {
    final successBody = {
      'id': 'key',
      'data': 'my_data',
      'usage_count': 0,
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
    };

    final stringBody = jsonEncode(successBody);

    test('should be able to get cache data by key successfully', () {
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

    test('should NOT be able to return data cached when kvs service fails', () {
      when(() => kvsService.get(key: 'my_key')).thenThrow(FakeAutoCacheException());

      expect(() => sut.get<String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.get(key: 'my_key')).called(1);
    });

    test('should NOT be able to return data when cryptography service fails', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(stringBody);
      when(() => cryptographyService.decrypt(stringBody)).thenThrow(FakeAutoCacheException());

      expect(() => sut.get<String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.get(key: 'my_key')).called(1);
      verify(() => cryptographyService.decrypt(stringBody)).called(1);
    });
  });

  group('QueryDataCacheDatasource.getList |', () {
    final successBody = {
      'id': 'key',
      'data': ['data', 'data'],
      'usage_count': 0,
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
    };

    final stringBody = jsonEncode(successBody);

    test('should be able to get list data cache successfully', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(stringBody);
      when(() => cryptographyService.decrypt(stringBody)).thenReturn(stringBody);

      final response = sut.getList<List<String>, String>('my_key');

      expect(response, isA<DataCacheEntity<List<String>>>());
      expect(response?.data, equals(['data', 'data']));
      verify(() => kvsService.get(key: 'my_key')).called(1);
      verify(() => cryptographyService.decrypt(stringBody)).called(1);
    });

    test('should be able to return NULL when not find list data in cache', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(null);

      final response = sut.getList<List<String>, String>('my_key');

      expect(response, isNull);
      verify(() => kvsService.get(key: 'my_key')).called(1);
      verifyNever(() => cryptographyService.decrypt(stringBody));
    });

    test('should NOT be able to get list data when kvs service fails', () {
      when(() => kvsService.get(key: 'my_key')).thenThrow(FakeAutoCacheException());

      expect(() => sut.getList<List<String>, String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.get(key: 'my_key')).called(1);
      verifyNever(() => cryptographyService.decrypt(stringBody));
    });

    test('should NOT be able to get list data when cryptography service fails', () {
      when(() => kvsService.get(key: 'my_key')).thenReturn(stringBody);
      when(() => cryptographyService.decrypt(stringBody)).thenThrow(FakeAutoCacheException());

      expect(() => sut.getList<List<String>, String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.get(key: 'my_key')).called(1);
      verify(() => cryptographyService.decrypt(stringBody)).called(1);
    });
  });

  group('QueryDataCacheDatasource.accomodateCache |', () {
    final cache = DataCacheEntity<String>(id: 'id', data: 'data', createdAt: createdAt, endAt: endAt);

    test('should be able to verify if cache can be accomodate successfully', () async {
      when(() => cryptographyService.encrypt(any())).thenReturn('encrypted_data');
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenAnswer((_) async => true);

      final response = await sut.accomodateCache<String>(cache);

      expect(response, isTrue);
      verify(() => cryptographyService.encrypt(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
    });

    test('should NOT be able to verify if cache can be accomodate when cryptography fails', () async {
      when(() => cryptographyService.encrypt(any())).thenThrow(FakeAutoCacheException());

      expect(() => sut.accomodateCache<String>(cache), throwsA(isA<AutoCacheException>()));
      verify(() => cryptographyService.encrypt(any())).called(1);
      verifyNever(() => sizeService.canAccomodateCache(any()));
    });

    test('should NOT be able to verify if cache can be accomodate when size service fails', () async {
      when(() => cryptographyService.encrypt(any())).thenReturn('encrypted_data');
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenThrow(FakeAutoCacheException());

      expect(() => sut.accomodateCache<String>(cache), throwsA(isA<AutoCacheException>()));
      verify(() => cryptographyService.encrypt(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
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
