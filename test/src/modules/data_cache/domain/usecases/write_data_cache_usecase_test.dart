import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/update_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_context.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/write_data_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class InvalidationCacheContextMock extends Mock implements IInvalidationCacheContext {}

class AutoCacheExceptionFake extends Fake implements AutoCacheException {}

class AutoCacheFailureFake extends Fake implements AutoCacheFailure {}

class FakeGetCacheDTO extends Fake implements GetCacheDTO {}

class FakeUpdateCacheDTO extends Fake implements UpdateCacheDTO<String> {}

class ReplaceFakeCacheConfig extends Fake implements CacheConfiguration {
  @override
  bool get replaceExpiredCache => true;
}

class NotReplaceFakeCacheConfig extends Fake implements CacheConfiguration {
  @override
  bool get replaceExpiredCache => false;
}

class BaseConfigFake extends Fake implements CacheConfiguration {
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
  final sut = WriteDataCacheUsecase(repository, invalidationContext);

  final fakeCache = CacheEntityFake<String>('my_string');

  final replaceFakeCacheConfig = ReplaceFakeCacheConfig();
  final notReplaceFakeCacheConfig = NotReplaceFakeCacheConfig();

  final fakeGetCacheDto = FakeGetCacheDTO();
  final fakeUpdateCacheDto = FakeUpdateCacheDTO();

  setUpAll(() {
    CacheConfigurationStore.instance.setConfiguration(BaseConfigFake());
  });

  setUp(() {
    registerFallbackValue(fakeCache);
    registerFallbackValue(fakeGetCacheDto);
    registerFallbackValue(fakeUpdateCacheDto);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationContext);
  });

  Matcher cacheDtoMatcher() {
    return predicate<GetCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('WriteCacheUsecase |', () {
    final replaceDto = WriteCacheDTO(key: 'my_key', data: 'my_data', cacheConfig: replaceFakeCacheConfig);
    final notReplaceDto = WriteCacheDTO(key: 'my_key', data: 'my_data', cacheConfig: notReplaceFakeCacheConfig);

    test('should be able to save cache data successfully when not find any previous cache with same key', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => repository.save<String>(replaceDto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => repository.save<String>(replaceDto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(fakeCache));
    });

    test('should be able to save cache data when is expired and config allows replace expired cache', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute(fakeCache)).thenReturn(left(AutoCacheFailureFake()));
      when(() => repository.save(replaceDto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verify(() => repository.save<String>(replaceDto)).called(1);
      verifyNever(() => repository.update<String>(any()));
    });

    test('should be able to update cache data when previous cache is not expired', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute(fakeCache)).thenReturn(right(unit));
      when(() => repository.update<String>(any())).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verify(() => repository.update<String>(any())).called(1);
      verifyNever(() => repository.save<String>(replaceDto));
    });

    test('should NOT be abel to save cache when is expired and config dont allow replacement', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute(fakeCache)).thenReturn(left(AutoCacheFailureFake()));

      final response = await sut.execute<String>(notReplaceDto);

      expect(response.isError, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verifyNever(() => repository.save<String>(notReplaceDto));
      verifyNever(() => repository.update<String>(any()));
    });

    test('should NOT be able to save cache repository when findByKey fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verifyNever(() => invalidationContext.execute<String>(any()));
      verifyNever(() => repository.save<String>(replaceDto));
      verifyNever(() => repository.update<String>(any()));
    });

    test('should NOT be able to save cache when save method at repository fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => repository.save<String>(replaceDto)).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => repository.save<String>(replaceDto)).called(1);
      verifyNever(() => repository.update<String>(any()));
    });

    test('should NOT be able to update cache  when update method at repository fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationContext.execute(fakeCache)).thenReturn(right(unit));
      when(() => repository.update<String>(any())).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationContext.execute<String>(fakeCache)).called(1);
      verify(() => repository.update<String>(any())).called(1);
      verifyNever(() => repository.save<String>(replaceDto));
    });
  });
}
