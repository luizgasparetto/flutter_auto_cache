import 'package:flutter_auto_cache/src/core/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/update_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_command_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_query_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/repositories/data_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class QueryDataCacheDatasourceMock extends Mock implements IQueryDataCacheDatasource {}

class CommandDataCacheDatasourceMock extends Mock implements ICommandDataCacheDatasource {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class FakeCacheConfig extends Fake implements CacheConfiguration {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {
  final T fakeData;

  DataCacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

void main() {
  final fakeCacheConfig = FakeCacheConfig();
  final queryDatasource = QueryDataCacheDatasourceMock();
  final commandDatasource = CommandDataCacheDatasourceMock();

  final sut = DataCacheRepository(queryDatasource, commandDatasource);

  tearDown(() {
    reset(queryDatasource);
    reset(commandDatasource);
  });

  group('DataCacheRepository.get |', () {
    const prefsDto = KeyCacheDTO(key: 'my_key');

    test('should be able to find cache data by key in prefs successfully', () {
      when(() => queryDatasource.get<String>('my_key')).thenReturn(DataCacheEntityFake<String>(fakeData: 'any_data'));

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });

    test('should be able to return NULL when cache not found data in prefs', () {
      when(() => queryDatasource.get<String>('my_key')).thenReturn(null);

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });

    test('should NOT be able to get cache in prefs when datasource throws an AutoCacheException', () {
      when(() => queryDatasource.get<String>('my_key')).thenThrow(FakeAutoCacheException());

      final response = sut.get<String>(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => queryDatasource.get<String>('my_key')).called(1);
    });
  });

  group('DataCacheRepository.getList |', () {
    final dataCache = DataCacheEntityFake<List<String>>(fakeData: ['data', 'data']);
    const dto = KeyCacheDTO(key: 'list_key');

    test('should be able to get a list of string in prefs successfully', () {
      when(() => queryDatasource.getList<List<String>, String>('list_key')).thenReturn(dataCache);

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals(dataCache));
      verify(() => queryDatasource.getList<List<String>, String>('list_key')).called(1);
    });

    test('should be able to get NULL when cache not found list data in prefs', () {
      when(() => queryDatasource.getList<List<String>, String>('list_key')).thenReturn(null);

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), isNull);
      verify(() => queryDatasource.getList<List<String>, String>('list_key')).called(1);
    });

    test('should NOT be able to get cache in prefs when datasource throws an AutoCacheException', () {
      when(() => queryDatasource.getList<List<String>, String>('list_key')).thenThrow(FakeAutoCacheException());

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => queryDatasource.getList<List<String>, String>('list_key')).called(1);
    });
  });

  group('DataCacheRepository.save |', () {
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

  group('DataCacheRepository.update |', () {
    final dto = UpdateCacheDTO(value: 'new_data', previewCache: DataCacheEntityFake(fakeData: 'fake_data'), config: FakeCacheConfig());

    test('should be able to update data cache with prefs successfully', () async {
      when(() => commandDatasource.update<String>(dto)).thenAsyncVoid();

      final response = await sut.update<String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => commandDatasource.update<String>(dto)).called(1);
    });

    test('should NOT be able to update data cache when datasource fails', () async {
      when(() => commandDatasource.update<String>(dto)).thenThrow(FakeAutoCacheException());

      final response = await sut.update<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => commandDatasource.update<String>(dto)).called(1);
    });
  });

  group('DataCacheRepository.delete |', () {
    const prefsDto = KeyCacheDTO(key: 'my_key');

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

  group('DataCacheRepository.clear |', () {
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
