import 'package:flutter_auto_cache/src/core/shared/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/shared/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/key_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/data_cache_substitution_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class SubstitutionDataCacheRepositoryMock extends Mock implements ISubstitutionDataCacheRepository {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final dataRepository = DataCacheRepositoryMock();
  final substitutionRepository = SubstitutionDataCacheRepositoryMock();

  final sut = LruSubstitutionCacheStrategy(dataRepository, substitutionRepository);

  setUp(() {
    registerFallbackValue(const KeyCacheDTO(key: 'any_key'));
  });

  tearDown(() {
    sut.dataCacheEntries.reset();
    reset(substitutionRepository);
    reset(dataRepository);
  });

  group('LruSubstitutionCacheStrategy.substitute |', () {
    final cache = DataCacheEntity.fakeConfig('fake_data');

    Matcher keyMatcher(String key) => predicate<KeyCacheDTO>((dto) => dto.key == key);

    final previewList = List.generate(3, (i) => DataCacheEntity.fakeConfig('my_data', key: 'key_$i', usageCount: i));
    final cacheList = [...previewList, null];

    test('should be able to substitute data cache using LRU successfully', () async {
      when(() => substitutionRepository.getAll()).thenReturn(right(cacheList));
      when(() => dataRepository.delete(any(that: keyMatcher('key_2')))).thenAnswer((_) => right(unit));
      when(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).thenAnswer((_) => right(true));

      final response = await sut.substitute<String>(cache);

      expect(response.isSuccess, isTrue);
      verify(() => substitutionRepository.getAll()).called(1);
      verify(() => dataRepository.delete(any(that: keyMatcher('key_2')))).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).called(1);
    });

    test('should be able to callback get cache key method when cannot substitue at first attempt', () async {
      when(() => substitutionRepository.getAll()).thenReturn(right(cacheList));
      when(() => dataRepository.delete(any(that: keyMatcher('key_2')))).thenAnswer((_) => right(unit));
      when(() => dataRepository.delete(any(that: keyMatcher('key_1')))).thenAnswer((_) => right(unit));
      when(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).thenAnswer((_) => right(false));
      when(() => substitutionRepository.accomodateCache(cache, key: 'key_1')).thenAnswer((_) => right(true));

      final response = await sut.substitute<String>(cache);

      expect(response.isSuccess, isTrue);
      verify(() => substitutionRepository.getAll()).called(1);
      verify(() => dataRepository.delete(any(that: keyMatcher('key_2')))).called(1);
      verify(() => dataRepository.delete(any(that: keyMatcher('key_1')))).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, key: 'key_1')).called(1);
    });

    test('should NOT be able to substitute using LRU when get all cache fails', () async {
      when(() => substitutionRepository.getAll()).thenReturn(left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getAll()).called(1);
      verifyNever(() => dataRepository.delete(any()));
      verifyNever(() => substitutionRepository.accomodateCache(cache, key: any(named: 'key')));
    });

    test('should NOT be able to substitute using LRU when delete fails', () async {
      when(() => substitutionRepository.getAll()).thenReturn(right(cacheList));
      when(() => dataRepository.delete(any(that: keyMatcher('key_2')))).thenAnswer((_) => left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getAll()).called(1);
      verify(() => dataRepository.delete(any(that: keyMatcher('key_2')))).called(1);
      verifyNever(() => substitutionRepository.accomodateCache(cache, key: 'key_2'));
    });

    test('should NOT be able to substitute using LRU when accomodate cache fails', () async {
      when(() => substitutionRepository.getAll()).thenReturn(right(cacheList));
      when(() => dataRepository.delete(any(that: keyMatcher('key_2')))).thenAnswer((_) => right(unit));
      when(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).thenAnswer((_) => left(FakeAutoCacheException()));

      final response = await sut.substitute<String>(cache);

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getAll()).called(1);
      verify(() => dataRepository.delete(any(that: keyMatcher('key_2')))).called(1);
      verify(() => substitutionRepository.accomodateCache(cache, key: 'key_2')).called(1);
    });
  });

  group('LruSubstitutionCacheStrategy.getKeys |', () {
    final previewList = List.generate(3, (i) => DataCacheEntity.fakeConfig('my_data', key: 'key_$i', usageCount: i));
    final cacheList = [...previewList, null];

    test('should be able to get cache key successfully', () {
      when(() => substitutionRepository.getAll()).thenReturn(right(cacheList));

      final response = sut.getCacheKey();

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals('key_2'));
      verify(() => substitutionRepository.getAll()).called(1);
    });

    test('should NOT be able to get cache key when substitution repository fails', () {
      when(() => substitutionRepository.getAll()).thenReturn(left(FakeAutoCacheException()));

      final response = sut.getCacheKey();

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<AutoCacheException>());
      verify(() => substitutionRepository.getAll()).called(1);
    });
  });
}
