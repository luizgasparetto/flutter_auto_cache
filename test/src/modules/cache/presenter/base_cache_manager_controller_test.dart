import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/exceptions/cache_exceptions.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/save_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCacheUsecaseMock extends Mock implements GetCacheUsecase {}

class SaveCacheUsecaseMock extends Mock implements SaveCacheUsecase {}

class FakeBindClass extends Fake {}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {
  final T fakeData;

  CacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final getCacheUsecase = GetCacheUsecaseMock();
  final saveCacheUsecase = SaveCacheUsecaseMock();

  final sut = BaseCacheManagerController(getCacheUsecase, saveCacheUsecase);

  setUp(() {
    Injector.I.bindFactory(FakeBindClass.new);
  });

  tearDown(() {
    reset(getCacheUsecase);
    reset(saveCacheUsecase);
    Injector.I.clear();
  });

  group('BaseCacheManagerController.get |', () {
    test('should be able to get data in cache with a key successfully', () async {
      when(() => getCacheUsecase.execute<String>(key: 'my_key')).thenAnswer((_) async {
        return right(CacheEntityFake<String>(fakeData: 'my_string_cached'));
      });

      final response = await sut.get<String>(key: 'my_key');

      expect(response, equals('my_string_cached'));
      verify(() => getCacheUsecase.execute<String>(key: 'my_key')).called(1);
    });

    test('should be able to get item in cache and return NULL', () async {
      when(() => getCacheUsecase.execute<String>(key: 'my_key')).thenAnswer((_) async {
        return right(null);
      });

      final response = await sut.get<String>(key: 'my_key');

      expect(response, isNull);
      verify(() => getCacheUsecase.execute<String>(key: 'my_key')).called(1);
    });

    test('should NOT be able to get data in cache when AutoCacheManager is not initialized', () async {
      Injector.I.clear();

      expect(Injector.I.hasBinds, equals(false));
      expect(AutoCacheManagerInitialazer.I.isInjectorInitialized, equals(false));
      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<NotInitializedAutoCacheManagerException>()));
      verifyNever(() => getCacheUsecase.execute<String>(key: 'my_key'));
    });

    test('should NOT be able to get item in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => getCacheUsecase.execute<String>(key: 'my_key')).thenAnswer((_) async {
        return left(FakeAutoCacheManagerException());
      });

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
    });
  });

  group('BaseCacheManagerController.save |', () {
    final saveDTO = SaveCacheDTO<String>.withConfig(key: 'my_key', data: 'my_data');

    test('should be able to save a data in cache with a key successfully', () async {
      when(() => saveCacheUsecase.execute<String>(saveDTO)).thenAnswer((_) async {
        return right(unit);
      });

      await expectLater(sut.save<String>(key: 'my_key', data: 'my_data'), completes);
      verify(() => saveCacheUsecase.execute<String>(saveDTO)).called(1);
    });

    test('should NOT be able to save data in cache when AutoCacheManager is not initialized', () async {
      Injector.I.clear();

      expect(Injector.I.hasBinds, equals(false));
      expect(AutoCacheManagerInitialazer.I.isInjectorInitialized, equals(false));

      expect(
        () => sut.save<String>(key: 'my_key', data: 'my_data'),
        throwsA(isA<NotInitializedAutoCacheManagerException>()),
      );

      verifyNever(() => saveCacheUsecase.execute<String>(saveDTO));
    });

    test('should NOT be able to save data in cache when UseCase throws an AutoCacheManagerException', () async {
      when(() => saveCacheUsecase.execute<String>(saveDTO)).thenAnswer((_) async {
        return left(FakeAutoCacheManagerException());
      });

      expect(() => sut.save<String>(key: 'my_key', data: 'my_data'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => saveCacheUsecase.execute<String>(saveDTO)).called(1);
    });
  });
}
