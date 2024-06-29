import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/delete_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/update_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/repositories/data_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class DataCacheDatasourceMock extends Mock implements IDataCacheDatasource {}

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
  final datasource = DataCacheDatasourceMock();

  final sut = DataCacheRepository(datasource);

  tearDown(() {
    reset(datasource);
  });

  group('DataCacheRepository.get |', () {
    const prefsDto = GetCacheDTO(key: 'my_key');

    test('should be able to find cache data by key in prefs successfully', () {
      when(() => datasource.get<String>('my_key')).thenReturn(DataCacheEntityFake<String>(fakeData: 'any_data'));

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success?.data, equals('any_data'));
      verify(() => datasource.get<String>('my_key')).called(1);
    });

    test('should be able to return NULL when cache not found data in prefs', () {
      when(() => datasource.get<String>('my_key')).thenReturn(null);

      final response = sut.get<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => datasource.get<String>('my_key')).called(1);
    });

    test('should NOT be able to get cache in prefs when datasource throws an AutoCacheException', () {
      when(() => datasource.get<String>('my_key')).thenThrow(FakeAutoCacheException());

      final response = sut.get<String>(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.get<String>('my_key')).called(1);
    });
  });

  group('DataCacheRepository.getList |', () {
    final dataCache = DataCacheEntityFake<List<String>>(fakeData: ['data', 'data']);
    const dto = GetCacheDTO(key: 'list_key');

    test('should be able to get a list of string in prefs successfully', () {
      when(() => datasource.getList<List<String>, String>('list_key')).thenReturn(dataCache);

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals(dataCache));
      verify(() => datasource.getList<List<String>, String>('list_key')).called(1);
    });

    test('should be able to get NULL when cache not found list data in prefs', () {
      when(() => datasource.getList<List<String>, String>('list_key')).thenReturn(null);

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), isNull);
      verify(() => datasource.getList<List<String>, String>('list_key')).called(1);
    });

    test('should NOT be able to get cache in prefs when datasource throws an AutoCacheException', () {
      when(() => datasource.getList<List<String>, String>('list_key')).thenThrow(FakeAutoCacheException());

      final response = sut.getList<List<String>, String>(dto);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => datasource.getList<List<String>, String>('list_key')).called(1);
    });
  });

  group('DataCacheRepository.getEncryptedData |', () {
    final cache = DataCacheEntityFake<String>(fakeData: 'fake_data');

    test('should be able to get encrypted data successfully', () {
      when(() => datasource.getEncryptData<String>(cache)).thenReturn('encrypted_data');

      final response = sut.getEncryptedData<String>(cache);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals('encrypted_data'));
      verify(() => datasource.getEncryptData<String>(cache)).called(1);
    });

    test('should NOT be able to get encrypted data when datasource fails', () {
      when(() => datasource.getEncryptData<String>(cache)).thenThrow(FakeAutoCacheException());

      final response = sut.getEncryptedData<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => datasource.getEncryptData<String>(cache)).called(1);
    });
  });

  group('DataCacheRepository.getKeys |', () {
    test('should be able to get keys of prefs datasource successfully', () {
      when(() => datasource.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response.isSuccess, isTrue);
      expect(response.success, equals(['keys']));
      verify(() => datasource.getKeys()).called(1);
    });

    test('should NOT be able to get keys of prefs when prefs datasource fails', () {
      when(() => datasource.getKeys()).thenThrow(FakeAutoCacheException());

      final response = sut.getKeys();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.getKeys()).called(1);
    });
  });

  group('DataCacheRepository.save |', () {
    final prefsDto = WriteCacheDTO<String>(key: 'my_key', data: 'my_data', cacheConfig: fakeCacheConfig);

    test('should be able to save cache data with prefs successfully', () async {
      when(() => datasource.save<String>(prefsDto)).thenAsyncVoid();

      final response = await sut.save<String>(prefsDto);

      expect(response.isSuccess, isTrue);
      verify(() => datasource.save<String>(prefsDto)).called(1);
    });

    test('should NOT be able to save cache when prefs datasource throws an AutoCacheManagerException', () async {
      when(() => datasource.save<String>(prefsDto)).thenThrow(FakeAutoCacheException());

      final response = await sut.save<String>(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.save<String>(prefsDto)).called(1);
    });
  });

  group('DataCacheRepository.update |', () {
    final dto = UpdateCacheDTO(previewCache: DataCacheEntityFake(fakeData: 'fake_data'), config: FakeCacheConfig());

    test('should be able to update data cache with prefs successfully', () async {
      when(() => datasource.update<String>(dto)).thenAsyncVoid();

      final response = await sut.update<String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => datasource.update<String>(dto)).called(1);
    });

    test('should NOT be able to update data cache when datasource fails', () async {
      when(() => datasource.update<String>(dto)).thenThrow(FakeAutoCacheException());

      final response = await sut.update<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.update<String>(dto)).called(1);
    });
  });

  group('DataCacheRepository.delete |', () {
    const prefsDto = DeleteCacheDTO(key: 'my_key');

    test('should be able to delete prefs cache by key successfully', () async {
      when(() => datasource.delete('my_key')).thenAsyncVoid();

      final response = await sut.delete(prefsDto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => datasource.delete('my_key')).called(1);
    });

    test('should NOT be able to delete prefs cache when datasource fails', () async {
      when(() => datasource.delete('my_key')).thenThrow(FakeAutoCacheException());

      final response = await sut.delete(prefsDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.delete('my_key')).called(1);
    });
  });

  group('DataCacheRepository.clear |', () {
    test('should be able to clear prefs data successfully', () async {
      when(datasource.clear).thenAsyncVoid();

      final response = await sut.clear();

      expect(response.isSuccess, isTrue);
      verify(datasource.clear).called(1);
    });

    test('should NOT be able to clear prefs data when datasource fails', () async {
      when(datasource.clear).thenThrow(FakeAutoCacheException());

      final response = await sut.clear();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(datasource.clear).called(1);
    });
  });
}
