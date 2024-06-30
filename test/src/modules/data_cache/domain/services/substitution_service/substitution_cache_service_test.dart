import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cache_size_service/i_cache_size_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/delete_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/substitution_policies.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigurationMock extends Mock implements CacheConfiguration {}

class CacheSizeServiceMock extends Mock implements ICacheSizeService {}

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class FakeDataCacheEntity extends Fake implements DataCacheEntity<String> {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final configuration = CacheConfigurationMock();
  final sizeService = CacheSizeServiceMock();
  final repository = DataCacheRepositoryMock();

  final sut = SubstitutionCacheService(configuration, sizeService, repository);

  final fakeCacheEntity = FakeDataCacheEntity();
  final dataOptions = DataCacheOptions(substitutionPolicy: SubstitutionPolicies.fifo);
  const deleteDto = DeleteCacheDTO(key: 'any');

  setUp(() {
    registerFallbackValue(fakeCacheEntity);
    registerFallbackValue(deleteDto);
  });

  tearDown(() {
    reset(configuration);
    reset(sizeService);
    reset(repository);
  });

  group('SubstitutionCacheService.substitute |', () {
    test('should be able to substitute cache when cache size cannot accomodate new data cache', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(right('encrypted_data'));
      when(() => repository.getKeys()).thenReturn(right(['key']));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenReturn(right(false));
      when(() => sizeService.canAccomodateCache('encrypted_data', recursive: true)).thenReturn(right(true));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isSuccess, isTrue);
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data', recursive: true)).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => repository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
    });

    test('should be able to callback when cache size can accomodate new data cache', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(right('encrypted_data'));
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenReturn(right(true));

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isSuccess, isTrue);
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
      verifyNever(() => configuration.dataCacheOptions);
      verifyNever(() => repository.getKeys());
      verifyNever(() => repository.delete(any()));
    });

    test('should NOT be able to substitute cache when getEncryptedData fails', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verifyNever(() => sizeService.canAccomodateCache('encrypted_data'));
      verifyNever(() => configuration.dataCacheOptions);
      verifyNever(() => repository.getKeys());
      verifyNever(() => repository.delete(any()));
    });

    test('should NOT be able to substitute cachen when size service fails', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(right('encrypted_data'));
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
      verifyNever(() => configuration.dataCacheOptions);
      verifyNever(() => repository.getKeys());
      verifyNever(() => repository.delete(any()));
    });

    test('should NOT be able to substitute cache when strategy fails', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(right('encrypted_data'));
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenReturn(right(false));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);
      when(() => repository.getKeys()).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => repository.getKeys()).called(1);
    });

    test('should NOT be able to substitute cache when canAccomodateCache recursive fails', () async {
      when(() => repository.getEncryptedData<String>(any())).thenReturn(right('encrypted_data'));
      when(() => repository.getKeys()).thenReturn(right(['key']));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));
      when(() => configuration.dataCacheOptions).thenReturn(dataOptions);
      when(() => sizeService.canAccomodateCache('encrypted_data')).thenReturn(right(false));

      when(() => sizeService.canAccomodateCache('encrypted_data', recursive: true)).thenReturn(
        left(FakeAutoCacheException()),
      );

      final response = await sut.substitute<String>('data', () => right(unit));

      expect(response.isError, isTrue);
      verify(() => repository.getEncryptedData<String>(any())).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data')).called(1);
      verify(() => sizeService.canAccomodateCache('encrypted_data', recursive: true)).called(1);
      verify(() => configuration.dataCacheOptions).called(1);
      verify(() => repository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
    });
  });
}
