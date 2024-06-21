import 'package:auto_cache_manager/src/core/config/stores/cache_config_store.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/repositories/i_cache_repository.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_context.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/save_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements ICacheRepository {}

class InvalidationCacheContextMock extends Mock implements IInvalidationCacheContext {}

class AutoCacheExceptionFake extends Fake implements AutoCacheException {}

class AutoCacheFailureFake extends Fake implements AutoCacheFailure {}

class FakeCacheConfig extends Fake implements CacheConfig {}

class FakeGetCacheDTO extends Fake implements GetCacheDTO {}

class BaseConfigFake extends Fake implements CacheConfig {
  @override
  InvalidationType get invalidationType => InvalidationType.ttl;
}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {
  final T fakeData;

  CacheEntityFake(this.fakeData);

  @override
  T get data => fakeData;
}

void main() {
  final repository = CacheRepositoryMock();
  final invalidationContext = InvalidationCacheContextMock();
  final sut = SaveCache(repository, invalidationContext);

  final fakeCache = CacheEntityFake<String>('my_string');
  final fakeCacheConfig = FakeCacheConfig();
  final fakeGetCacheDto = FakeGetCacheDTO();

  setUpAll(() {
    CacheConfigStore.instance.setConfig(BaseConfigFake());
  });

  setUp(() {
    registerFallbackValue(fakeCache);
    registerFallbackValue(fakeGetCacheDto);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationContext);
  });

  Matcher cacheDtoMatcher() {
    return predicate<GetCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('SaveCache |', () {
    final dto = WriteCacheDTO(
      key: 'my_key',
      data: 'my_data',
      cacheConfig: fakeCacheConfig,
    );

    test('should be able to save cache data successfully when not find any previous cache with same key', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => repository.save<String>(dto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => repository.save<String>(dto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(fakeCache));
    });

    test('should NOT be able to save cache repository when findByKey fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verifyNever(() => invalidationContext.execute<String>(any()));
      verifyNever(() => repository.save<String>(dto));
    });

    test('should NOT be able to save cache repository when InvalidationCacheContext fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute<String>(fakeCache)).thenReturn(left(AutoCacheFailureFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheFailure>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verifyNever(() => repository.save<String>(dto));
    });

    test('should NOT be able to save cache repository when save method fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute<String>(fakeCache)).thenAnswer((_) => right(unit));
      when(() => repository.save<String>(dto)).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verify(() => repository.save<String>(dto)).called(1);
    });
  });
}
