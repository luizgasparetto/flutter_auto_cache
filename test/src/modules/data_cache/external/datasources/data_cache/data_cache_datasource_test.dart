import 'dart:convert';

import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cache_size_service/cache_size_service.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/i_cryptography_service.dart';
import 'package:flutter_auto_cache/src/core/services/kvs_service/i_kvs_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/datasources/data_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../commons/extensions/when_extensions.dart';

class PrefsServiceMock extends Mock implements IKvsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class CacheSizeServiceMock extends Mock implements ICacheSizeService {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final prefsService = PrefsServiceMock();
  final cryptographyService = CryptographyServiceMock();
  final sizeService = CacheSizeServiceMock();

  final sut = DataCacheDatasource(prefsService, cryptographyService, sizeService);

  tearDown(() {
    reset(prefsService);
    reset(cryptographyService);
    reset(sizeService);
  });

  group('DataCacheDatasource.get |', () {
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
      when(() => prefsService.get(key: 'my_key')).thenThrow(FakeAutoCacheException());

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
      when(() => prefsService.getKeys()).thenThrow(FakeAutoCacheException());

      expect(() => sut.getKeys(), throwsA(isA<AutoCacheException>()));
    });
  });

  group('DataCacheDatasource.save |', () {
    final config = CacheConfiguration.defaultConfig();
    final dto = WriteCacheDTO<String>(key: 'my_key', data: 'data', cacheConfig: config);

    Matcher matcher() {
      return predicate<String>((json) => json.contains('data') && json.contains('my_key'));
    }

    test('should be able to save data in prefs cache succesfully', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).thenAsyncVoid();

      await expectLater(sut.save(dto), completes);
      verify(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });

    test('should NOT be able to save data in prefs when service fails', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).thenThrow(FakeAutoCacheException());

      expect(() => sut.save(dto), throwsA(isA<AutoCacheException>()));
      verify(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });
  });

  group('DataCacheDatasource.delete |', () {
    test('should be able to delete data in prefs cache successfully', () async {
      when(() => prefsService.delete(key: 'my_key')).thenAsyncVoid();

      await expectLater(sut.delete('my_key'), completes);
      verify(() => prefsService.delete(key: 'my_key')).called(1);
    });

    test('should NOT be able to delete data in prefs cache when service fails', () async {
      when(() => prefsService.delete(key: 'my_key')).thenThrow(FakeAutoCacheException());

      expect(() => sut.delete('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => prefsService.delete(key: 'my_key')).called(1);
    });
  });

  group('DataCacheDatasource.clear |', () {
    test('should be able to clear prefs cache data successfully', () async {
      when(prefsService.clear).thenAsyncVoid();

      await expectLater(sut.clear(), completes);
      verify(prefsService.clear).called(1);
    });

    test('should NOT be able to clear prefs when service fails', () async {
      when(prefsService.clear).thenThrow(FakeAutoCacheException());

      expect(sut.clear, throwsA(isA<AutoCacheException>()));
      verify(prefsService.clear).called(1);
    });
  });
}
