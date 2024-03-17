import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/extensions/when_extensions.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/datasources/i_key_value_storage_datasource.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/datasources/i_sql_storage_datasource.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/repositories/cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class KVSDatasourceMock extends Mock implements IKeyValueStorageDatasource {}

class SQLDatasourceMock extends Mock implements ISQLStorageDatasource {}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {
  final T fakeData;

  CacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final kvsDatasource = KVSDatasourceMock();
  final sqlDatasource = SQLDatasourceMock();

  final sut = CacheRepository(kvsDatasource, sqlDatasource);

  const sqlConfig = CacheConfig(storageType: StorageType.sql, invalidationType: InvalidationType.ttl);
  final kvsConfig = CacheConfig.defaultConfig();

  tearDown(() {
    reset(kvsDatasource);
    reset(sqlDatasource);
  });

  tearDownAll(() {
    AutoCacheManagerInitialazer.I.setConfig(CacheConfig.defaultConfig());
  });

  group('CacheRepository.findByKey |', () {
    test('should be able to find cache data by key in KVS successfully', () async {
      when(() => kvsDatasource.findByKey<String>('my_key')).thenReturn(CacheEntityFake<String>(fakeData: 'any_data'));

      AutoCacheManagerInitialazer.I.setConfig(kvsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => kvsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should be able to return NULL when cache not found data in KVS', () async {
      when(() => kvsDatasource.findByKey<String>('my_key')).thenReturn(null);

      AutoCacheManagerInitialazer.I.setConfig(kvsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => kvsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should NOT be able to find cache data in KVS when datasource throws an AutoCacheManagerException', () async {
      when(() => kvsDatasource.findByKey<String>('my_key')).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitialazer.I.setConfig(kvsConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => kvsDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => sqlDatasource.findByKey<String>('my_key'));
    });

    test('should be able to find cache data by key in SQL successfully', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenAnswer((_) async {
        return CacheEntityFake<String>(fakeData: 'any_data');
      });

      AutoCacheManagerInitialazer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => kvsDatasource.findByKey<String>('my_key'));
    });

    test('should be able to return NULL when cache not found data in SQL', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenAnswer((_) async => null);

      AutoCacheManagerInitialazer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => kvsDatasource.findByKey<String>('my_key'));
    });

    test('should NOT be able to find cache data in SQL when datasource throws an AutoCacheManagerException', () async {
      when(() => sqlDatasource.findByKey<String>('my_key')).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitialazer.I.setConfig(sqlConfig);
      final response = await sut.findByKey<String>('my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => sqlDatasource.findByKey<String>('my_key')).called(1);
      verifyNever(() => kvsDatasource.findByKey<String>('my_key'));
    });
  });

  group('CacheRepository.save |', () {
    final dto = SaveCacheDTO<String>.withConfig(key: 'my_key', data: 'my_data');

    test('should be able to save cache data with KVS successfully', () async {
      when(() => kvsDatasource.save<String>(dto)).thenAsyncVoid();

      AutoCacheManagerInitialazer.I.setConfig(kvsConfig);
      final response = await sut.save<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => kvsDatasource.save<String>(dto)).called(1);
      verifyNever(() => sqlDatasource.save<String>(dto));
    });

    test('should NOT be able to save cache when KVS datasource throws an AutoCacheManagerException', () async {
      when(() => kvsDatasource.save<String>(dto)).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitialazer.I.setConfig(kvsConfig);
      final response = await sut.save<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => kvsDatasource.save<String>(dto)).called(1);
      verifyNever(() => sqlDatasource.save<String>(dto));
    });

    test('should be able to save cache data with SQL successfully', () async {
      when(() => sqlDatasource.save<String>(dto)).thenAsyncVoid();

      AutoCacheManagerInitialazer.I.setConfig(sqlConfig);
      final response = await sut.save<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => sqlDatasource.save<String>(dto)).called(1);
      verifyNever(() => kvsDatasource.save<String>(dto));
    });

    test('should NOT be able to save cache when SQL datasource throws an AutoCacheManagerException', () async {
      when(() => sqlDatasource.save<String>(dto)).thenThrow(FakeAutoCacheManagerException());

      AutoCacheManagerInitialazer.I.setConfig(sqlConfig);
      final response = await sut.save<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => sqlDatasource.save<String>(dto)).called(1);
      verifyNever(() => kvsDatasource.save<String>(dto));
    });
  });
}
