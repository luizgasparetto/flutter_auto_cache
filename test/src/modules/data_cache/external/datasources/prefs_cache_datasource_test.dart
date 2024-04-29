import 'dart:convert';

import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/i_cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/storages/prefs/i_prefs_service.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/external/datasources/prefs_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class PrefsServiceMock extends Mock implements IPrefsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final service = PrefsServiceMock();
  final cryptographyService = CryptographyServiceMock();

  final sut = PrefsCacheDatasource(service, cryptographyService);

  tearDown(() {
    reset(service);
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
      when(() => service.get(key: 'my_key')).thenReturn(stringBody);

      final response = sut.get<String>('my_key');

      expect(response, isA<CacheEntity<String>>());
      expect(response?.data, equals('my_data'));
      verify(() => service.get(key: 'my_key')).called(1);
    });

    test('should be able to return NULL when not find data in cache', () {
      when(() => service.get(key: 'my_key')).thenReturn(null);

      final response = sut.get<String>('my_key');

      expect(response, isNull);
      verify(() => service.get(key: 'my_key')).called(1);
    });

    test('should NOT be able to return data cached when service fails', () async {
      when(() => service.get(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.get<String>('my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => service.get(key: 'my_key')).called(1);
    });
  });

  group('PrefsDatasource.save |', () {
    final config = CacheConfig.defaultConfig();
    final dto = SaveCacheDTO<String>(key: 'my_key', data: 'data', storageType: StorageType.prefs, cacheConfig: config);

    Matcher matcher() {
      return predicate<String>((json) => json.contains('data') && json.contains('my_key'));
    }

    test('should be able to save data in prefs cache succesfully', () async {
      when(() => service.save(key: 'my_key', data: any(named: 'data', that: matcher()))).thenAsyncVoid();

      await expectLater(sut.save(dto), completes);
      verify(() => service.save(key: 'my_key', data: any(named: 'data', that: matcher()))).called(1);
    });

    test('should NOT be able to save data in prefs when service fails', () async {
      when(() => service.save(key: 'my_key', data: any(named: 'data', that: matcher()))).thenThrow(
        FakeAutoCacheManagerException(),
      );

      expect(() => sut.save(dto), throwsA(isA<AutoCacheManagerException>()));
      verify(() => service.save(key: 'my_key', data: any(named: 'data', that: matcher()))).called(1);
    });
  });

  group('PrefsDatasource.delete |', () {
    test('should be able to delete data in prefs cache successfully', () async {
      when(() => service.delete(key: 'my_key')).thenAsyncVoid();

      await expectLater(sut.delete('my_key'), completes);
      verify(() => service.delete(key: 'my_key')).called(1);
    });

    test('should NOT be able to delete data in prefs cache when service fails', () async {
      when(() => service.delete(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.delete('my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => service.delete(key: 'my_key')).called(1);
    });
  });

  group('PrefsDatasource.clear |', () {
    test('should be able to clear prefs cache data successfully', () async {
      when(service.clear).thenAsyncVoid();

      await expectLater(sut.clear(), completes);
      verify(service.clear).called(1);
    });

    test('should NOT be able to clear prefs when service fails', () async {
      when(service.clear).thenThrow(FakeAutoCacheManagerException());

      expect(sut.clear, throwsA(isA<AutoCacheManagerException>()));
      verify(service.clear).called(1);
    });
  });

  group('PrefsDatasource.getKeys |', () {
    test('should be able to get keys successfully when calls service', () async {
      when(() => service.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response, ['keys']);
      verify(() => service.getKeys()).called(1);
    });

    test('should NOT be able to get keys when service fails', () async {
      when(() => service.getKeys()).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getKeys(), throwsA(isA<AutoCacheManagerException>()));
    });
  });
}
