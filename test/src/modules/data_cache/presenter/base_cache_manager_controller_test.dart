import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/exceptions/initializer_exceptions.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/clear_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/save_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCacheUsecaseMock extends Mock implements GetCacheUsecase {}

class SaveCacheUsecaseMock extends Mock implements SaveCacheUsecase {}

class ClearCacheUsecaseMock extends Mock implements ClearCacheUsecase {}

class CacheConfigMock extends Mock implements CacheConfig {}

class FakeBindClass extends Fake {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

class FakeGetCacheDTO extends Fake implements GetCacheDTO {}

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
  final cacheConfigMock = CacheConfigMock();

  final sut = BaseCacheManagerController(
    getCacheUsecase,
    saveCacheUsecase,
    clearCacheUsecase,
    cacheConfigMock,
    storageType: StorageType.prefs,
  );

  setUp(() {
    Injector.I.bindFactory(FakeBindClass.new);
    registerFallbackValue(FakeGetCacheDTO());
  });

  tearDown(() {
    reset(getCacheUsecase);
    reset(saveCacheUsecase);
    reset(clearCacheUsecase);
    reset(cacheConfigMock);
    Injector.I.clear();
  });

  Matcher cacheDtoMatcher() {
    return predicate<GetCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('BaseCacheManagerController.get |', () {
    test('should be able to get data in cache with a key successfully', () async {
      when(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher()))).thenAnswer(
        (_) async => right(CacheEntityFake<String>(fakeData: 'my_string_cached')),
      );

      final response = await sut.get<String>(key: 'my_key');

      expect(response, equals('my_string_cached'));
      verify(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher()))).called(1);
    });

    test('should be able to get item in cache and return NULL', () async {
      when(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher()))).thenAnswer((_) async => right(null));

      final response = await sut.get<String>(key: 'my_key');

      expect(response, isNull);
      verify(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to get data in cache when AutoCacheManager is not initialized', () async {
      Injector.I.clear();

      expect(Injector.I.hasBinds, equals(false));
      expect(AutoCacheManagerInitializer.I.isInjectorInitialized, equals(false));
      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<NotInitializedAutoCacheManagerException>()));
      verifyNever(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher())));
    });

    test('should NOT be able to get item in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => getCacheUsecase.execute<String>(any(that: cacheDtoMatcher()))).thenAnswer(
        (_) async => left(FakeAutoCacheManagerException()),
      );

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
    });
  });

  group('BaseCacheManagerController.save |', () {
    final saveDTO = SaveCacheDTO(
      key: 'my_key',
      data: 'my_data',
      storageType: StorageType.prefs,
      cacheConfig: cacheConfigMock,
    );

    test('should be able to save a data in cache with a key successfully', () async {
      when(() => saveCacheUsecase.execute<String>(saveDTO)).thenAnswer((_) async => right(unit));

      await expectLater(sut.save<String>(key: 'my_key', data: 'my_data'), completes);
      verify(() => saveCacheUsecase.execute<String>(saveDTO)).called(1);
    });

    test('should NOT be able to save data in cache when AutoCacheManager is not initialized', () async {
      Injector.I.clear();

      expect(Injector.I.hasBinds, equals(false));
      expect(AutoCacheManagerInitializer.I.isInjectorInitialized, equals(false));

      expect(
        () => sut.save<String>(key: 'my_key', data: 'my_data'),
        throwsA(isA<NotInitializedAutoCacheManagerException>()),
      );

      verifyNever(() => saveCacheUsecase.execute<String>(saveDTO));
    });

    test('should NOT be able to save data in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => saveCacheUsecase.execute<String>(saveDTO)).thenAnswer(
        (_) async => left(FakeAutoCacheManagerException()),
      );

      expect(() => sut.save<String>(key: 'my_key', data: 'my_data'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => saveCacheUsecase.execute<String>(saveDTO)).called(1);
    });
  });
}
