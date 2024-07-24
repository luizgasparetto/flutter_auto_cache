import 'package:flutter_auto_cache/src/core/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/protocols/cache_response.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/protocols/enums/cache_response_status.dart';
import 'package:flutter_auto_cache/src/core/services/service_locator/implementations/service_locator.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/clear_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/delete_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/get_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/write_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/presenter/controllers/implementations/base_data_cache_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCacheUsecaseMock extends Mock implements IGetDataCacheUsecase {}

class WriteDataCacheUsecaseMock extends Mock implements IWriteDataCacheUsecase {}

class ClearDataCacheUsecaseMock extends Mock implements IClearDataCacheUsecase {}

class DeleteDataCacheUsecaseMock extends Mock implements IDeleteDataCacheUsecase {}

class CacheConfigMock extends Mock implements CacheConfiguration {}

class FakeBindClass extends Fake {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class FakeKeyCacheDTO extends Fake implements KeyCacheDTO {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {
  final T fakeData;

  DataCacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

void main() {
  final getCacheUsecase = GetCacheUsecaseMock();
  final writeCacheUsecase = WriteDataCacheUsecaseMock();
  final clearCacheUsecase = ClearDataCacheUsecaseMock();
  final deleteCacheUsecase = DeleteDataCacheUsecaseMock();

  final cacheConfigMock = CacheConfigMock();

  final sut = BaseDataCacheController(
    getCacheUsecase,
    writeCacheUsecase,
    clearCacheUsecase,
    deleteCacheUsecase,
    cacheConfigMock,
  );

  setUp(() {
    ServiceLocator.instance.bindFactory(FakeBindClass.new);
    registerFallbackValue(FakeKeyCacheDTO());
  });

  tearDown(() {
    reset(getCacheUsecase);
    reset(writeCacheUsecase);
    reset(clearCacheUsecase);
    reset(deleteCacheUsecase);
    reset(cacheConfigMock);

    ServiceLocator.instance.resetBinds();
  });

  Matcher getCacheDtoMatcher() {
    return predicate<KeyCacheDTO>((dto) => dto.key == 'my_key');
  }

  Matcher deleteCacheDtoMatcher() {
    return predicate<KeyCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('BaseDataCacheController.get |', () {
    final successData = DataCacheEntityFake<String>(fakeData: 'my_string_cached');

    test('should be able to get data in cache with a key successfully', () async {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(
        right(SuccessCacheResponse(data: successData.data)),
      );

      final response = await sut.get<String>(key: 'my_key');

      expect(response.data, equals('my_string_cached'));
      expect(response.status, equals(CacheResponseStatus.success));
      verify(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should be able to get item in cache and return NULL when not find cache item', () async {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(right(NotFoundCacheResponse()));

      final response = await sut.get<String>(key: 'my_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
      verify(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should be able to get item in cache and return NULL when cache item is expired', () async {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(right(ExpiredCacheResponse()));

      final response = await sut.get<String>(key: 'my_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
      verify(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to get item in cache when UseCase throws an AutoCacheException', () {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(left(FakeAutoCacheException()));

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<AutoCacheException>()));
    });
  });

  group('BaseDataCacheController.getList |', () {
    final successData = DataCacheEntityFake<List<String>>(fakeData: ['fake_list_data']);

    test('should be able to get data list in cache with a key successfully', () async {
      when(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).thenReturn(
        right(SuccessCacheResponse(data: successData.data)),
      );

      final response = await sut.getList<String>(key: 'my_key');

      expect(response.data, equals(['fake_list_data']));
      expect(response.status, equals(CacheResponseStatus.success));
      verify(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should be able to return NULL on get data list when not find cache item', () async {
      when(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).thenReturn(right(NotFoundCacheResponse()));

      final response = await sut.getList<String>(key: 'my_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
      verify(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should be able to return NULL on get data list when cache item is expired', () async {
      when(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).thenReturn(right(ExpiredCacheResponse()));

      final response = await sut.getList<String>(key: 'my_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
      verify(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to get data list when usecase fails', () {
      when(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).thenReturn(left(FakeAutoCacheException()));

      expect(() => sut.getList<String>(key: 'my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => getCacheUsecase.execute<List<String>, String>(any(that: getCacheDtoMatcher()))).called(1);
    });
  });

  group('BaseDataCacheController.save |', () {
    const dto = WriteCacheDTO(key: 'my_key', data: 'my_data');

    test('should be able to save a data in cache with a key successfully', () async {
      when(() => writeCacheUsecase.execute<String>(dto)).thenAnswer((_) async => right(unit));

      await expectLater(sut.save<String>(key: 'my_key', data: 'my_data'), completes);
      verify(() => writeCacheUsecase.execute<String>(dto)).called(1);
    });

    test('should NOT be able to save data in cache when UseCase throws an AutoCacheException', () async {
      when(() => writeCacheUsecase.execute<String>(dto)).thenAnswer(
        (_) async => left(FakeAutoCacheException()),
      );

      expect(() => sut.save<String>(key: 'my_key', data: 'my_data'), throwsA(isA<AutoCacheException>()));
      verify(() => writeCacheUsecase.execute<String>(dto)).called(1);
    });
  });

  group('BaseDataCacheController.delete |', () {
    test('should be able to delete data in cache by key succesfully', () async {
      when(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).thenAnswer((_) async => right(unit));

      await expectLater(sut.delete(key: 'my_key'), completes);
      verify(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to delete data in cache when usecase fails', () async {
      when(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).thenAnswer((_) async => left(FakeAutoCacheException()));

      expect(() => sut.delete(key: 'my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).called(1);
    });
  });

  group('BaseDataCacheController.clear |', () {
    test('should be able to clear all cache data successfully', () async {
      when(() => clearCacheUsecase.execute()).thenAnswer((_) async => right(unit));

      await expectLater(sut.clear(), completes);
      verify(() => clearCacheUsecase.execute()).called(1);
    });

    test('should NOT be able to clear all cache data when usecase fails', () async {
      when(() => clearCacheUsecase.execute()).thenAnswer((_) async => left(FakeAutoCacheException()));

      expect(() => sut.clear(), throwsA(isA<AutoCacheException>()));
      verify(() => clearCacheUsecase.execute()).called(1);
    });
  });
}
