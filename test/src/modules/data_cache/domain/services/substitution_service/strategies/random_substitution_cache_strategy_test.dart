import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class SubstitutionDataCacheRepositoryMock extends Mock implements ISubstitutionDataCacheRepository {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class FakeDataCacheEntity extends Fake implements DataCacheEntity<String> {}

void main() {
  final repository = DataCacheRepositoryMock();
  final substitutionRepository = SubstitutionDataCacheRepositoryMock();

  final sut = RandomSubstitutionCacheStrategy(repository, substitutionRepository);

  final keys = List.generate(100, (index) => 'key_$index');
  const deleteDto = KeyCacheDTO(key: 'any_key');

  setUp(() {
    registerFallbackValue(deleteDto);
  });

  tearDown(() {
    reset(repository);
    reset(substitutionRepository);
  });

  group('RandomSubstitutionCacheStrategy.substitute |', () {
    final cache = FakeDataCacheEntity();

    test('should be able to substitute data cache successfully', () async {
      when(() => substitutionRepository.getKeys()).thenReturn(right(keys));
      when(() => repository.delete(any())).thenAnswer((_) async => right(unit));
      when(() => substitutionRepository.accomodateCache(cache, recursive: true)).thenAnswer((_) async => right(true));

      final response = await sut.substitute<String>(cache);

      expect(response.isSuccess, isTrue);
      verify(() => substitutionRepository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, recursive: true)).called(1);
    });

    test('should NOT be able to substitute data cache when get keys failed', () async {
      when(() => substitutionRepository.getKeys()).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getKeys()).called(1);
    });

    test('should NOT be able to substitute cache when delete cache fails', () async {
      when(() => substitutionRepository.getKeys()).thenReturn(right(keys));
      when(() => repository.delete(any())).thenAnswer((_) async => left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
    });

    test('should NOT be able to complete substitution method when accomodate cache fails', () async {
      when(() => substitutionRepository.getKeys()).thenReturn(right(keys));
      when(() => repository.delete(any())).thenAnswer((_) => right(unit));
      when(() => substitutionRepository.accomodateCache(cache, recursive: true)).thenAnswer((_) => left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      verify(() => substitutionRepository.getKeys()).called(1);
      verify(() => repository.delete(any())).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, recursive: true)).called(1);
    });
  });

  group('RandomSubstitutionCacheStrategy.getCacheKey |', () {
    test('should be able to get random cache key successfully', () {
      when(() => substitutionRepository.getKeys()).thenReturn(right(keys));

      final response = sut.getCacheKey();

      expect(response.isSuccess, isTrue);
      expect(keys, contains(response.success));
      verify(() => substitutionRepository.getKeys()).called(1);
    });

    test('should NOT be able to get random cache key when repository fails', () {
      when(() => substitutionRepository.getKeys()).thenReturn(left(FakeAutoCacheException()));

      final response = sut.getCacheKey();

      expect(response.isError, isTrue);
      verify(() => substitutionRepository.getKeys()).called(1);
    });
  });
}
