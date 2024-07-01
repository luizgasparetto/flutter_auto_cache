import 'package:flutter_auto_cache/src/core/configuration/stores/cache_configuration_store.dart';
import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/update_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation/invalidation_types.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/write_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class InvalidationCacheServiceMock extends Mock implements IInvalidationCacheService {}

class SubstitutionCacheServiceMock extends Mock implements ISubstitutionCacheService {}

class AutoCacheExceptionFake extends Fake implements AutoCacheException {}

class FakeGetCacheDTO extends Fake implements GetCacheDTO {}

class FakeUpdateCacheDTO extends Fake implements UpdateCacheDTO<String> {}

class ReplaceFakeCacheConfig extends Fake implements CacheConfiguration {
  @override
  DataCacheOptions get dataCacheOptions => DataCacheOptions(replaceExpiredCache: true);
}

class NotReplaceFakeCacheConfig extends Fake implements CacheConfiguration {
  @override
  DataCacheOptions get dataCacheOptions => DataCacheOptions(replaceExpiredCache: false);
}

class BaseConfigFake extends Fake implements CacheConfiguration {
  @override
  DataCacheOptions get dataCacheOptions => DataCacheOptions(invalidationType: InvalidationTypes.ttl);
}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {
  final T fakeData;

  DataCacheEntityFake(this.fakeData);

  @override
  T get data => fakeData;
}

void main() {
  final repository = CacheRepositoryMock();
  final invalidationService = InvalidationCacheServiceMock();
  final substitutionService = SubstitutionCacheServiceMock();

  final sut = WriteDataCacheUsecase(repository, substitutionService, invalidationService);

  final fakeCache = DataCacheEntityFake<String>('my_string');
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
    reset(substitutionService);
    reset(invalidationService);
  });

  Matcher cacheDtoMatcher() {
    return predicate<GetCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('WriteCacheUsecase |', () {
    final replaceDto = WriteCacheDTO(key: 'my_key', data: 'my_data', cacheConfig: replaceFakeCacheConfig);
    final notReplaceDto = WriteCacheDTO(key: 'my_key', data: 'my_data', cacheConfig: notReplaceFakeCacheConfig);

    test('should be able to save cache data successfully when not find any previous cache with same key', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => substitutionService.substitute(replaceDto.data)).thenAnswer((_) async => right(unit));
      when(() => repository.save<String>(replaceDto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => repository.save<String>(replaceDto)).called(1);
      verifyNever(() => invalidationService.validate<String>(fakeCache));
    });

    test('should be able to save cache data when is expired and config allows replace expired cache', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationService.validate(fakeCache)).thenReturn(right(false));
      when(() => substitutionService.substitute<String>(replaceDto.data)).thenAnswer((_) async => right(unit));
      when(() => repository.save(replaceDto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
      verify(() => repository.save<String>(replaceDto)).called(1);
      verify(() => substitutionService.substitute<String>(replaceDto.data)).called(1);
      verifyNever(() => repository.update<String>(any()));
    });

    test('should be able to update cache data when previous cache is not expired', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationService.validate(fakeCache)).thenReturn(right(true));
      when(() => substitutionService.substitute<String>(replaceDto.data)).thenAnswer((_) async => right(unit));
      when(() => repository.update<String>(any())).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
      verify(() => repository.update<String>(any())).called(1);
      verify(() => substitutionService.substitute<String>(replaceDto.data)).called(1);
      verifyNever(() => repository.save<String>(replaceDto));
    });

    test('should NOT be abel to save cache when is expired and config dont allow replacement', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationService.validate(fakeCache)).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(notReplaceDto);

      expect(response.isError, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
      verifyNever(() => repository.save<String>(notReplaceDto));
      verifyNever(() => repository.update<String>(any()));
    });

    test('should NOT be able to save cache repository when findByKey fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verifyNever(() => invalidationService.validate<String>(any()));
      verifyNever(() => repository.save<String>(replaceDto));
      verifyNever(() => repository.update<String>(any()));
    });

    test('should NOT be able to save cache when save method at repository fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => substitutionService.substitute<String>(replaceDto.data)).thenAnswer((_) async => right(unit));
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
      when(() => invalidationService.validate(fakeCache)).thenReturn(right(true));
      when(() => substitutionService.substitute<String>(replaceDto.data)).thenAnswer((_) async => right(unit));
      when(() => repository.update<String>(any())).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
      verify(() => repository.update<String>(any())).called(1);
      verify(() => substitutionService.substitute<String>(replaceDto.data)).called(1);
      verifyNever(() => repository.save<String>(replaceDto));
    });

    test('should NOT be able to write cache when substitution service fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => substitutionService.substitute<String>(replaceDto.data)).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(replaceDto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => substitutionService.substitute<String>(replaceDto.data)).called(1);
      verifyNever(() => repository.save<String>(replaceDto));
      verifyNever(() => repository.update<String>(any()));
    });
  });
}
