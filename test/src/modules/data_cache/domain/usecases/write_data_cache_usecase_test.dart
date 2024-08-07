import 'package:flutter_auto_cache/src/core/domain/services/invalidation_service/invalidation_cache_service.dart';
import 'package:flutter_auto_cache/src/core/shared/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/shared/configuration/notifiers/cache_configuration_notifier.dart';
import 'package:flutter_auto_cache/src/core/shared/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/shared/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/factories/data_cache_factory.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/write_data_cache_usecase.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class InvalidationCacheServiceMock extends Mock implements IInvalidationCacheService {}

class SubstitutionCacheServiceMock extends Mock implements ISubstitutionCacheService {}

class DataCacheFactoryMock extends Mock implements IDataCacheFactory {}

class AutoCacheExceptionFake extends Fake implements AutoCacheException {}

class FakeKeyCacheDTO extends Fake implements KeyCacheDTO {}

class FakeCacheConfig extends Fake implements CacheConfiguration {
  @override
  DataCacheOptions get dataCacheOptions => const DataCacheOptions();
}

class BaseConfigFake extends Fake implements CacheConfiguration {
  @override
  DataCacheOptions get dataCacheOptions => const DataCacheOptions();
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
  final dataCacheFactory = DataCacheFactoryMock();

  final sut = WriteDataCacheUsecase(repository, substitutionService, invalidationService, dataCacheFactory);

  final fakeCache = DataCacheEntityFake<String>('my_string');
  final updatedFakeCache = DataCacheEntityFake<String>('my_data');

  final fakeGetCacheDto = FakeKeyCacheDTO();

  setUpAll(() {
    CacheConfigurationNotifier.instance.setConfiguration(BaseConfigFake());
  });

  setUp(() {
    registerFallbackValue(fakeCache);
    registerFallbackValue(fakeGetCacheDto);
  });

  tearDown(() {
    reset(repository);
    reset(substitutionService);
    reset(invalidationService);
    reset(dataCacheFactory);
  });

  Matcher cacheDtoMatcher() {
    return predicate<KeyCacheDTO>((dto) => dto.key == 'my_key');
  }

  group('WriteCacheUsecase |', () {
    const dto = WriteCacheDTO(key: 'my_key', data: 'my_data');

    test('should be able to save cache data successfully when not find any previous cache with same key', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => dataCacheFactory.save<String>(dto)).thenReturn(fakeCache);
      when(() => substitutionService.substitute(fakeCache.data)).thenAnswer((_) async => right(unit));
      when(() => repository.write<String>(fakeCache)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => dataCacheFactory.save<String>(dto)).called(1);
      verify(() => repository.write<String>(fakeCache)).called(1);
      verifyNever(() => invalidationService.validate<String>(fakeCache));
    });

    test('should be able to update cache data when previous cache is not expired', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationService.validate(fakeCache)).thenReturn(right(true));
      when(() => dataCacheFactory.update<String>(dto.data, fakeCache)).thenReturn(updatedFakeCache);
      when(() => substitutionService.substitute<String>(updatedFakeCache.data)).thenAnswer((_) async => right(unit));
      when(() => repository.write<String>(updatedFakeCache)).thenAnswer((_) async => right(unit));

      final response = await sut.execute<String>(dto);

      expect(response.isSuccess, isTrue);
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
      verify(() => dataCacheFactory.update<String>(dto.data, fakeCache)).called(1);
      verify(() => substitutionService.substitute<String>(updatedFakeCache.data)).called(1);
      verify(() => repository.write<String>(updatedFakeCache)).called(1);
    });

    test('should NOT be able to write cache when findByKey fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
    });

    test('should NOT be able to write cache when invalidation fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(fakeCache));
      when(() => invalidationService.validate(fakeCache)).thenReturn(left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => invalidationService.validate<String>(fakeCache)).called(1);
    });

    test('should NOT be able to save cache when substitution fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => dataCacheFactory.save<String>(dto)).thenReturn(fakeCache);
      when(() => substitutionService.substitute<String>(fakeCache.data)).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => dataCacheFactory.save<String>(dto)).called(1);
      verify(() => substitutionService.substitute<String>(fakeCache.data)).called(1);
    });

    test('should NOT be able to save cache when write method at repository fails', () async {
      when(() => repository.get<String>(any(that: cacheDtoMatcher()))).thenReturn(right(null));
      when(() => dataCacheFactory.save<String>(dto)).thenReturn(fakeCache);
      when(() => substitutionService.substitute<String>(fakeCache.data)).thenAnswer((_) async => right(unit));
      when(() => repository.write<String>(fakeCache)).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute<String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(any(that: cacheDtoMatcher()))).called(1);
      verify(() => dataCacheFactory.save<String>(dto)).called(1);
      verify(() => substitutionService.substitute<String>(fakeCache.data)).called(1);
      verify(() => repository.write<String>(fakeCache)).called(1);
    });
  });
}
