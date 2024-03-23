import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/extensions/when_extensions.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/clear_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/datasources/i_prefs_datasource.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/datasources/i_sql_storage_datasource.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/repositories/cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PrefsDatasourceMock extends Mock implements IPrefsDatasource {}

class SQLDatasourceMock extends Mock implements ISQLStorageDatasource {}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {
  final T fakeData;

  CacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final prefsDatasource = PrefsDatasourceMock();
  final sqlDatasource = SQLDatasourceMock();

  final sut = CacheRepository(prefsDatasource, sqlDatasource);

  final sqlConfig = CacheConfig(storageType: StorageType.sql, invalidationType: InvalidationType.ttl);
  final prefsConfig = CacheConfig.defaultConfig();

  tearDown(() {
    reset(prefsDatasource);
    reset(sqlDatasource);
  });

  tearDownAll(() {
    AutoCacheManagerInitializer.I.setConfig(CacheConfig.defaultConfig());
  });

  group('CacheRepository.findByKey |', () {
    test('should be able to find cache data by key in prefs successfully', () async {
      when(() => prefsDatasource.findByKey<String>('my_key'))
          .thenReturn(Future.value(CacheEntityFake<String>(fakeData: 'any_data')));

      AutoCacheManagerInitializer.I.setConfig(prefsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => prefsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should be able to return NULL when cache not found data in prefs', () async {
      when(() => prefsDatasource.findByKey<String>('my_key')).thenReturn(Future.value());

      AutoCacheManagerInitializer.I.setConfig(prefsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => prefsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should NOT be able to find cache data in prefs when datasource throws an AutoCacheManagerException',
        () async {
      when(() => prefsDatasource.findByKey<String>('my_key')).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitializer.I.setConfig(prefsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => prefsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should be able to find cache data by key in SQL successfully', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenAnswer((_) async {
        return CacheEntityFake<String>(fakeData: 'any_data');
      });

      AutoCacheManagerInitializer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => prefsDatasource.findByKey<String>('my_key'));
    });

    test('should be able to return NULL when cache not found data in SQL', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenAnswer((_) async => null);

      AutoCacheManagerInitializer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => prefsDatasource.findByKey<String>('my_key'));
    });

    test('should NOT be able to find cache data in SQL when datasource throws an AutoCacheManagerException', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitializer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => prefsDatasource.findByKey<String>('my_key'));
    });
  });

  group('CacheRepository.save |', () {
    final dto = SaveCacheDTO<String>.withConfig(key: 'my_key', data: 'my_data');

    test('should be able to save cache data with prefs successfully', () async {
      when(() => prefsDatasource.save<String>(dto)).thenAsyncVoid();

      AutoCacheManagerInitializer.I.setConfig(prefsConfig);
      final response = await sut.save<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => prefsDatasource.save<String>(dto)).called(1);
      verifyNever(() => sqlDatasource.save<String>(dto));
    });

    test('should NOT be able to save cache when prefs datasource throws an AutoCacheManagerException', () async {
      when(() => prefsDatasource.save<String>(dto)).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitializer.I.setConfig(prefsConfig);
      final response = await sut.save<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => prefsDatasource.save<String>(dto)).called(1);
      verifyNever(() => sqlDatasource.save<String>(dto));
    });

    test('should be able to save cache data with SQL successfully', () async {
      when(() => sqlDatasource.save<String>(dto)).thenAsyncVoid();

      AutoCacheManagerInitializer.I.setConfig(sqlConfig);
      final response = await sut.save<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => sqlDatasource.save<String>(dto)).called(1);
      verifyNever(() => prefsDatasource.save<String>(dto));
    });

    test('should NOT be able to save cache when SQL datasource throws an AutoCacheManagerException', () async {
      when(() => sqlDatasource.save<String>(dto)).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitializer.I.setConfig(sqlConfig);
      final response = await sut.save<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => sqlDatasource.save<String>(dto)).called(1);
      verifyNever(() => prefsDatasource.save<String>(dto));
    });
  });

  group('CacheRepository.clear |', () {
    const prefsDTO = ClearCacheDTO(storageType: StorageType.prefs);
    const sqlDTO = ClearCacheDTO(storageType: StorageType.sql);

    test('should be able to clear prefs data successfully', () async {
      when(prefsDatasource.clear).thenAsyncVoid();

      final response = await sut.clear(prefsDTO);

      expect(response.isSuccess, isTrue);
      verify(prefsDatasource.clear).called(1);
      verifyNever(sqlDatasource.clear);
    });

    test('should be able to clear SQL data successfully', () async {
      when(sqlDatasource.clear).thenAsyncVoid();

      final response = await sut.clear(sqlDTO);

      expect(response.isSuccess, isTrue);
      verify(sqlDatasource.clear).called(1);
      verifyNever(prefsDatasource.clear);
    });

    test('should NOT be able to clear prefs data when datasource fails', () async {
      when(prefsDatasource.clear).thenThrow(FakeAutoCacheManagerException());

      final response = await sut.clear(prefsDTO);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(prefsDatasource.clear).called(1);
      verifyNever(sqlDatasource.clear);
    });

    test('should NOT be able to clear SQL data when datasource fails', () async {
      when(sqlDatasource.clear).thenThrow(FakeAutoCacheManagerException());

      final response = await sut.clear(sqlDTO);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(sqlDatasource.clear).called(1);
      verifyNever(prefsDatasource.clear);
    });
  });
}
