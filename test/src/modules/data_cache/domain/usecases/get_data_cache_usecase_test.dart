import 'package:flutter_auto_cache/src/core/domain/services/invalidation_service/invalidation_cache_service.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/protocols/enums/cache_response_status.dart';
import 'package:flutter_auto_cache/src/core/shared/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/shared/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/factories/data_cache_factory.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/get_data_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class InvalidationCacheServiceMock extends Mock implements IInvalidationCacheService {}

class DataCacheFactoryMock extends Mock implements IDataCacheFactory {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {}

void main() {
  final repository = DataCacheRepositoryMock();
  final invalidationService = InvalidationCacheServiceMock();
  final dataCacheFactory = DataCacheFactoryMock();

  final sut = GetDataCacheUsecase(repository, invalidationService, dataCacheFactory);

  final cacheFake = DataCacheEntityFake<String>();
  const dto = KeyCacheDTO(key: 'fake_key');

  setUp(() {
    registerFallbackValue(cacheFake);
    registerFallbackValue(dto);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationService);
    reset(dataCacheFactory);
  });

  group('GetDataCacheUsecase |', () {
    const dto = KeyCacheDTO(key: 'my_key');

    final dataCache = DataCacheEntity.fakeConfig('cache_data');
    final usedCache = DataCacheEntity.fakeConfig('used_cache');

    final listDataCache = DataCacheEntity.fakeConfig(const ['data', 'data']);
    final usedListCache = DataCacheEntity.fakeConfig(const ['data', 'data']);

    test('should be able to get data in cache successfully', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(dataCache));
      when(() => invalidationService.validate<String>(dataCache)).thenReturn(right(true));
      when(() => dataCacheFactory.used<String>(dataCache)).thenReturn(usedCache);
      when(() => repository.write<String>(usedCache)).thenAnswer((_) => right(unit));

      final response = await sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success.data, dataCache.data);
      expect(response.success.status, equals(CacheResponseStatus.success));
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationService.validate<String>(dataCache)).called(1);
      verify(() => dataCacheFactory.used<String>(dataCache)).called(1);
      verify(() => repository.write<String>(usedCache)).called(1);
    });

    test('should be able to get data in cache if data is NULL', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(null));

      final response = await sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success.data, isNull);
      expect(response.success.status, equals(CacheResponseStatus.notFound));
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationService.validate<String>(any<DataCacheEntity<String>>()));
    });

    test('should be able to get LIST data in cache successfully', () async {
      when(() => repository.getList<List<String>, String>(dto)).thenReturn(right(listDataCache));
      when(() => invalidationService.validate<List<String>>(listDataCache)).thenReturn(right(true));
      when(() => dataCacheFactory.used<List<String>>(listDataCache)).thenReturn(usedListCache);
      when(() => repository.write<List<String>>(usedListCache)).thenAnswer((_) => right(unit));

      final response = await sut.execute<List<String>, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success.data, listDataCache.data);
      expect(response.success.status, equals(CacheResponseStatus.success));
      verify(() => repository.getList<List<String>, String>(dto)).called(1);
      verify(() => invalidationService.validate<List<String>>(listDataCache)).called(1);
      verify(() => dataCacheFactory.used<List<String>>(listDataCache)).called(1);
      verify(() => repository.write<List<String>>(usedListCache)).called(1);
    });

    test('should be able to return NULL when data cache is invalid and delete remaining cache', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(dataCache));
      when(() => invalidationService.validate<String>(dataCache)).thenReturn(right(false));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));

      final response = await sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success.data, isNull);
      expect(response.success.status, equals(CacheResponseStatus.expired));
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationService.validate<String>(dataCache)).called(1);
      verify(() => repository.delete(any())).called(1);
    });

    test('should NOT be able to get data in cache when get retrives an exception', () async {
      when(() => repository.get<String>(dto)).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationService.validate<String>(any<DataCacheEntity<String>>()));
    });

    test('should NOT be able o get list data in cache when repository retrives an exception', () async {
      when(() => repository.getList<List<String>, String>(dto)).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.execute<List<String>, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.getList<List<String>, String>(dto)).called(1);
      verifyNever(() => invalidationService.validate<List<String>>(listDataCache));
    });

    test('should NOT be able to get data in cache when invalidation context retrives an exception', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(dataCache));
      when(() => invalidationService.validate<String>(dataCache)).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationService.validate<String>(dataCache)).called(1);
    });

    test('should NOT be able to delete data cache when is invalid if repository fails', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(dataCache));
      when(() => invalidationService.validate<String>(dataCache)).thenReturn(right(false));
      when(() => repository.delete(any())).thenAnswer((_) => left(FakeAutoCacheException()));

      final response = await sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationService.validate<String>(dataCache)).called(1);
      verify(() => repository.delete(any())).called(1);
    });

    test('should NOT be able to write update count when repository fails', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(dataCache));
      when(() => invalidationService.validate<String>(dataCache)).thenReturn(right(true));
      when(() => dataCacheFactory.used<String>(dataCache)).thenReturn(usedCache);
      when(() => repository.write<String>(usedCache)).thenAnswer((_) => left(FakeAutoCacheException()));

      final response = await sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationService.validate<String>(dataCache)).called(1);
      verify(() => dataCacheFactory.used<String>(dataCache)).called(1);
      verify(() => repository.write<String>(usedCache)).called(1);
    });
  });
}
