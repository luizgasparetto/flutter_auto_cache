import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/service_locator/implementations/service_locator.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/delete_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/clear_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/delete_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/save_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCacheUsecaseMock extends Mock implements GetCacheUsecase {}

class SaveCacheUsecaseMock extends Mock implements SaveCacheUsecase {}

class ClearCacheUsecaseMock extends Mock implements ClearCacheUsecase {}

class DeleteCacheUsecaseMock extends Mock implements DeleteCacheUsecase {}

class CacheConfigMock extends Mock implements CacheConfig {}

class FakeBindClass extends Fake {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

class FakeGetCacheDTO extends Fake implements GetCacheDTO {}

class FakeDeleteCacheDTO extends Fake implements DeleteCacheDTO {}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {
  final T fakeData;

  CacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

void main() {
  final getCacheUsecase = GetCacheUsecaseMock();
  final saveCacheUsecase = SaveCacheUsecaseMock();
  final clearCacheUsecase = ClearCacheUsecaseMock();
  final deleteCacheUsecase = DeleteCacheUsecaseMock();

  final cacheConfigMock = CacheConfigMock();

  final sut = BaseCacheManagerController(
    getCacheUsecase,
    saveCacheUsecase,
    clearCacheUsecase,
    deleteCacheUsecase,
    cacheConfigMock,
  );

  setUp(() {
    ServiceLocator.instance.bindFactory(FakeBindClass.new);

    registerFallbackValue(FakeGetCacheDTO());
    registerFallbackValue(FakeDeleteCacheDTO());
  });

  tearDown(() {
    reset(getCacheUsecase);
    reset(saveCacheUsecase);
    reset(clearCacheUsecase);
    reset(deleteCacheUsecase);
    reset(cacheConfigMock);

    ServiceLocator.instance.resetBinds();
  });

  Matcher getCacheDtoMatcher() {
    return predicate<GetCacheDTO>((dto) => dto.key == 'my_key');
  }

  Matcher deleteCacheDtoMatcher() {
    return predicate<DeleteCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('BaseCacheManagerController.get |', () {
    test('should be able to get data in cache with a key successfully', () {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(
        right(CacheEntityFake<String>(fakeData: 'my_string_cached')),
      );

      final response = sut.get<String>(key: 'my_key');

      expect(response, equals('my_string_cached'));
      verify(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should be able to get item in cache and return NULL', () {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(right(null));

      final response = sut.get<String>(key: 'my_key');

      expect(response, isNull);
      verify(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to get item in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => getCacheUsecase.execute<String, String>(any(that: getCacheDtoMatcher()))).thenReturn(
        left(FakeAutoCacheManagerException()),
      );

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<AutoCacheException>()));
    });
  });

  group('BaseCacheManagerController.save |', () {
    final dto = WriteCacheDTO(key: 'my_key', data: 'my_data', cacheConfig: cacheConfigMock);

    test('should be able to save a data in cache with a key successfully', () async {
      when(() => saveCacheUsecase.execute<String>(dto)).thenAnswer((_) async => right(unit));

      await expectLater(sut.save<String>(key: 'my_key', data: 'my_data'), completes);
      verify(() => saveCacheUsecase.execute<String>(dto)).called(1);
    });

    test('should NOT be able to save data in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => saveCacheUsecase.execute<String>(dto)).thenAnswer(
        (_) async => left(FakeAutoCacheManagerException()),
      );

      expect(() => sut.save<String>(key: 'my_key', data: 'my_data'), throwsA(isA<AutoCacheException>()));
      verify(() => saveCacheUsecase.execute<String>(dto)).called(1);
    });
  });

  group('BaseCacheManagerController.delete |', () {
    test('should be able to delete data in cache by key succesfully', () async {
      when(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).thenAnswer((_) async => right(unit));

      await expectLater(sut.delete(key: 'my_key'), completes);
      verify(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to delete data in cache when usecase fails', () async {
      when(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).thenAnswer(
        (_) async => left(FakeAutoCacheManagerException()),
      );

      expect(() => sut.delete(key: 'my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => deleteCacheUsecase.execute(any(that: deleteCacheDtoMatcher()))).called(1);
    });
  });

  group('BaseCacheManagerController.clear |', () {
    test('should be able to clear all cache data successfully', () async {
      when(() => clearCacheUsecase.execute()).thenAnswer((_) async => right(unit));

      await expectLater(sut.clear(), completes);
      verify(() => clearCacheUsecase.execute()).called(1);
    });

    test('should NOT be able to clear all cache data when usecase fails', () async {
      when(() => clearCacheUsecase.execute()).thenAnswer((_) async => left(FakeAutoCacheManagerException()));

      expect(() => sut.clear(), throwsA(isA<AutoCacheException>()));
      verify(() => clearCacheUsecase.execute()).called(1);
    });
  });
}
