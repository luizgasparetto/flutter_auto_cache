import 'dart:convert';

import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/i_cryptography_service.dart';
import 'package:flutter_auto_cache/src/core/services/kvs_service/i_kvs_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/datasources/query_data_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PrefsServiceMock extends Mock implements IKvsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

void main() {
  final prefsService = PrefsServiceMock();
  final cryptographyService = CryptographyServiceMock();

  final sut = QueryDataCacheDatasource(prefsService, cryptographyService);

  tearDown(() {
    reset(prefsService);
    reset(cryptographyService);
  });

  group('PrefsDatasource.get |', () {
    final createdAt = DateTime.now();
    final endAt = DateTime.now().add(const Duration(hours: 3));

    final successBody = {
      'id': 'key',
      'data': 'my_data',
      'invalidation_type': InvalidationType.ttl.name,
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
    };

    final stringBody = jsonEncode(successBody);

    test('should be able to find cache data by key successfully', () {
      when(() => prefsService.get(key: 'my_key')).thenReturn(stringBody);
      when(() => cryptographyService.decrypt(stringBody)).thenReturn(stringBody);

      final response = sut.get<String>('my_key');

      expect(response, isA<DataCacheEntity<String>>());
      expect(response?.data, equals('my_data'));
      verify(() => prefsService.get(key: 'my_key')).called(1);
    });

    test('should be able to return NULL when not find data in cache', () {
      when(() => prefsService.get(key: 'my_key')).thenReturn(null);

      final response = sut.get<String>('my_key');

      expect(response, isNull);
      verify(() => prefsService.get(key: 'my_key')).called(1);
    });

    test('should NOT be able to return data cached when service fails', () async {
      when(() => prefsService.get(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.get<String>('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => prefsService.get(key: 'my_key')).called(1);
    });
  });

  group('PrefsDatasource.getKeys |', () {
    test('should be able to get keys successfully when calls service', () async {
      when(() => prefsService.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response, ['keys']);
      verify(() => prefsService.getKeys()).called(1);
    });

    test('should NOT be able to get keys when service fails', () async {
      when(() => prefsService.getKeys()).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getKeys(), throwsA(isA<AutoCacheException>()));
    });
  });
}
