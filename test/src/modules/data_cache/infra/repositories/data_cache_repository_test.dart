import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/delete_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_command_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_query_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/repositories/data_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class CommandDataCacheDatasourceMock extends Mock implements ICommandDataCacheDatasource {}

class QueryDataCacheDatasourceMock extends Mock implements IQueryDataCacheDatasource {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class FakeCacheConfig extends Fake implements CacheConfiguration {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {
  final T fakeData;

  DataCacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

void main() {
  final commandDatasource = CommandDataCacheDatasourceMock();
  final queryDatasource = QueryDataCacheDatasourceMock();

  final fakeCacheConfig = FakeCacheConfig();

  final sut = DataCacheRepository(queryDatasource, commandDatasource);

  tearDown(() {
    reset(queryDatasource);
    reset(commandDatasource);
  });

  group('CacheRepository.get |', () {
    const prefsDto = GetCacheDTO(key: 'my_key');

    test('should be able to find cache data by key in prefs successfully', () async {
      when(() => queryDatasource.get<String>('my_key')).thenReturn(DataCacheEntityFake<String>(fakeData: 'any_data'));

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });

    test('should be able to return NULL when cache not found data in prefs', () async {
      when(() => queryDatasource.get<String>('my_key')).thenReturn(null);

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });

    test('should NOT be able to get cache in prefs when datasource throws an AutoCacheManagerException', () async {
      when(() => queryDatasource.get<String>('my_key')).thenThrow(FakeAutoCacheException());

      final response = sut.get<String>(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });
  });

  group('CacheRepository.getKeys |', () {
    test('should be able to get keys of prefs datasource successfully', () async {
      when(() => queryDatasource.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response.isSuccess, isTrue);
      expect(response.success, equals(['keys']));
      verify(() => queryDatasource.getKeys()).called(1);
    });

    test('should NOT be able to get keys of prefs when prefs datasource fails', () async {
      when(() => queryDatasource.getKeys()).thenThrow(FakeAutoCacheException());

      final response = sut.getKeys();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => queryDatasource.getKeys()).called(1);
    });
  });

  group('CacheRepository.save |', () {
    final prefsDto = WriteCacheDTO<String>(key: 'my_key', data: 'my_data', cacheConfig: fakeCacheConfig);

    test('should be able to save cache data with prefs successfully', () async {
      when(() => commandDatasource.save<String>(prefsDto)).thenAsyncVoid();

      final response = await sut.save<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      verify(() => commandDatasource.save<String>(prefsDto)).called(1);
    });

    test('should NOT be able to save cache when prefs datasource throws an AutoCacheManagerException', () async {
      when(() => commandDatasource.save<String>(prefsDto)).thenThrow(FakeAutoCacheException());

      final response = await sut.save<String>(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => commandDatasource.save<String>(prefsDto)).called(1);
    });
  });

  group('CacheRepository.delete |', () {
    const prefsDto = DeleteCacheDTO(key: 'my_key');

    test('should be able to delete prefs cache by key successfully', () async {
      when(() => commandDatasource.delete('my_key')).thenAsyncVoid();

      final response = await sut.delete(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => commandDatasource.delete('my_key')).called(1);
    });

    test('should NOT be able to delete prefs cache when datasource fails', () async {
      when(() => commandDatasource.delete('my_key')).thenThrow(FakeAutoCacheException());

      final response = await sut.delete(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => commandDatasource.delete('my_key')).called(1);
    });
  });

  group('CacheRepository.clear |', () {
    test('should be able to clear prefs data successfully', () async {
      when(commandDatasource.clear).thenAsyncVoid();

      final response = await sut.clear();

      expect(response.isSuccess, isTrue);
      verify(commandDatasource.clear).called(1);
    });

    test('should NOT be able to clear prefs data when datasource fails', () async {
      when(commandDatasource.clear).thenThrow(FakeAutoCacheException());

      final response = await sut.clear();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(commandDatasource.clear).called(1);
    });
  });
}
