import 'dart:convert';

import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/storages/prefs/i_prefs_service.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/external/datasources/prefs_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../extensions/when_extensions.dart';

class PrefsServiceMock extends Mock implements IPrefsService {}

class FakeAutoCacheManagerException extends Fake
    implements AutoCacheManagerException {}

void main() {
  final service = PrefsServiceMock();
  final sut = PrefsCacheDatasource(service);

  tearDown(() {
    reset(service);
  });

  group('PrefsDatasource.findByKey |', () {
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

      final response = sut.findByKey<String>('my_key');

      expect(response, isA<CacheEntity<String>>());
      verify(() => service.get(key: 'my_key')).called(1);
    });

    test('should be able to return NULL when not find data in cache', () {
      when(() => service.get(key: 'my_key')).thenReturn(null);

      final response = sut.findByKey<String>('my_key');

      expect(response, isNull);
      verify(() => service.get(key: 'my_key')).called(1);
    });

    test(
      'should NOT be able to return data cached when service fails',
      () async {
        when(() => service.get(key: 'my_key')).thenThrow(
          FakeAutoCacheManagerException(),
        );

        expect(
          () => sut.findByKey<String>('my_key'),
          throwsA(isA<AutoCacheManagerException>()),
        );
        verify(() => service.get(key: 'my_key')).called(1);
      },
    );
  });

  // group('PrefsDatasource.save |', () {
  //   const dto = SaveCacheDTO(key: 'my_key', data: 'my_data', storageType: StorageType.prefs);

  //   test('should be able to save data in prefs cache succesfully', () async {
  //     when(() => service.save(key: 'my_key', data: {})).thenAsyncVoid();

  //     await expectLater(sut.save(dto), completes);
  //     verify(() => service.save<String>(key: 'my_key', data: 'my_data')).called(1);
  //   });

  //   test('should NOT be able to save data in prefs when prefs service fails', () async {
  //     when(() => service.save<String>(key: 'my_key', data: 'my_data')).thenThrow(FakeAutoCacheManagerException());

  //     expect(() => sut.save(dto), throwsA(isA<AutoCacheManagerException>()));
  //     verify(() => service.save<String>(key: 'my_key', data: 'my_data')).called(1);
  //   });
  // });

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
}
