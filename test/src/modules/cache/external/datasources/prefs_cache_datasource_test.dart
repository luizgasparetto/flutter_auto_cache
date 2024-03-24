import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/storages/dtos/storage_dto.dart';
import 'package:auto_cache_manager/src/core/services/storages/kvs/i_prefs_service.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/external/datasources/prefs_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../extensions/when_extensions.dart';

class PrefsServiceMock extends Mock implements IPrefsService {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final service = PrefsServiceMock();
  final sut = PrefsCacheDatasource(service);

  tearDown(() {
    reset(service);
  });

  group('PrefsDatasource.findByKey |', () {
    final storageDto = StorageDTO<String>(
      id: 'my_key',
      data: 'my_data',
      invalidationTypeCode: InvalidationType.ttl.name,
      createdAt: DateTime.now(),
    );

    test('should be able to find cache data by key successfully', () {
      when(() => service.get<String>(key: 'my_key')).thenReturn(storageDto);

      final response = sut.findByKey<String>('my_key');

      expect(response, isA<CacheEntity<String>>());
      verify(() => service.get<String>(key: 'my_key')).called(1);
    });

    test('should be able to return NULL when not find data in cache', () {
      when(() => service.get<String>(key: 'my_key')).thenReturn(null);

      final response = sut.findByKey<String>('my_key');

      expect(response, isNull);
      verify(() => service.get<String>(key: 'my_key')).called(1);
    });

    test('should NOT be able to return data cached when service fails', () async {
      when(() => service.get<String>(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.findByKey<String>('my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => service.get<String>(key: 'my_key')).called(1);
    });
  });

  group('PrefsDatasource.save |', () {
    const dto = SaveCacheDTO(key: 'my_key', data: 'my_data', storageType: StorageType.prefs);

    test('should be able to save data in prefs cache succesfully', () async {
      when(() => service.save<String>(key: 'my_key', data: 'my_data')).thenAsyncVoid();

      await expectLater(sut.save(dto), completes);
      verify(() => service.save<String>(key: 'my_key', data: 'my_data')).called(1);
    });

    test('should NOT be able to save data in prefs when prefs service fails', () async {
      when(() => service.save<String>(key: 'my_key', data: 'my_data')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.save(dto), throwsA(isA<AutoCacheManagerException>()));
      verify(() => service.save<String>(key: 'my_key', data: 'my_data')).called(1);
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
}
