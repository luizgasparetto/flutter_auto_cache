import 'package:flutter_auto_cache/src/core/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/substitution_policies.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigurationMock extends Mock implements CacheConfiguration {}

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class SubstitutionDataCacheRepositoryMock extends Mock implements ISubstitutionDataCacheRepository {}

class FakeDataCacheEntity extends Fake implements DataCacheEntity<String> {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final configuration = CacheConfigurationMock();

  final repository = DataCacheRepositoryMock();
  final substitutionRepository = SubstitutionDataCacheRepositoryMock();

  final sut = SubstitutionCacheService(configuration, repository, substitutionRepository);

  final fakeCacheEntity = FakeDataCacheEntity();
  const dataOptions = DataCacheOptions(substitutionPolicy: SubstitutionPolicies.fifo);
  const deleteDto = KeyCacheDTO(key: 'any');

  setUp(() {
    registerFallbackValue(fakeCacheEntity);
    registerFallbackValue(deleteDto);
  });

  tearDown(() {
    reset(configuration);
    reset(repository);
    reset(substitutionRepository);
  });

  group('SubstitutionCacheService.substitute |', () {
    test('should be able to substitute cache when cache size cannot accomodate new data cache', () async {
      when(() => substitutionRepository.accomodateCache<String>(any())).thenReturn(right(false));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);
      when(() => substitutionRepository.getKeys()).thenReturn(right(['key']));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));
      when(() => substitutionRepository.accomodateCache<String>(any(), recursive: true)).thenReturn(right(true));

      final response = await sut.substitute<String>('data');

      expect(response.isSuccess, isTrue);
      verify(() => substitutionRepository.accomodateCache<String>(any())).called(1);
      verify(() => substitutionRepository.accomodateCache<String>(any(), recursive: true)).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => substitutionRepository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
    });

    test('should be able to callback when cache size can accomodate new data cache', () async {
      when(() => substitutionRepository.accomodateCache<String>(any())).thenReturn(right(true));

      final response = await sut.substitute<String>('data');

      expect(response.isSuccess, isTrue);
      verify(() => substitutionRepository.accomodateCache<String>(any())).called(1);
      verifyNever(() => configuration.dataCacheOptions);
      verifyNever(() => substitutionRepository.getKeys());
      verifyNever(() => repository.delete(any()));
    });

    test('should NOT be able to substitute cache when accomodateCache fails', () async {
      when(() => substitutionRepository.accomodateCache<String>(any())).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>('data');

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.accomodateCache<String>(any())).called(1);
      verifyNever(() => configuration.dataCacheOptions);
    });

    test('should NOT be able to substitute cache when strategy fails', () async {
      when(() => substitutionRepository.accomodateCache<String>(any())).thenReturn(right(false));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);
      when(() => substitutionRepository.getKeys()).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>('data');

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.accomodateCache<String>(any())).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => substitutionRepository.getKeys()).called(1);
    });

    test('should NOT be able to substitute cache when canAccomodateCache recursive fails', () async {
      when(() => substitutionRepository.accomodateCache<String>(any())).thenReturn(right(false));
      when(() => substitutionRepository.accomodateCache<String>(any(), recursive: true)).thenReturn(left(FakeAutoCacheException()));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);
      when(() => substitutionRepository.getKeys()).thenReturn(right(['key']));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));

      final response = await sut.substitute<String>('data');

      expect(response.isError, isTrue);
      verify(() => substitutionRepository.accomodateCache<String>(any())).called(1);
      verify(() => substitutionRepository.accomodateCache<String>(any(), recursive: true)).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => substitutionRepository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
    });
  });
}
