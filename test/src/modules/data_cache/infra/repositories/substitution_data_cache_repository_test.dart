import 'package:flutter_auto_cache/src/core/shared/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/datasources/i_query_data_cache_datasource.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/infra/repositories/substitution_data_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class QueryDataCacheDatasourceMock extends Mock implements IQueryDataCacheDatasource {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {
  final T fakeData;

  DataCacheEntityFake({required this.fakeData});

  @override
  T get data => fakeData;
}

void main() {
  final datasource = QueryDataCacheDatasourceMock();
  final sut = SubstitutionDataCacheRepository(datasource);

  tearDown(() {
    reset(datasource);
  });
  group('DataCacheRepository.getKeys |', () {
    test('should be able to get keys of prefs datasource successfully', () {
      when(() => datasource.getKeys()).thenReturn(['keys']);

      final response = sut.getKeys();

      expect(response.isSuccess, isTrue);
      expect(response.success, equals(['keys']));
      verify(() => datasource.getKeys()).called(1);
    });

    test('should NOT be able to get keys of prefs when prefs datasource fails', () {
      when(() => datasource.getKeys()).thenThrow(FakeAutoCacheException());

      final response = sut.getKeys();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => datasource.getKeys()).called(1);
    });
  });

  group('DataCacheRepository.accomodateCache |', () {
    final cache = DataCacheEntityFake(fakeData: 'fake_data');

    test('should be able to verify if can accomodate cache successfully', () async {
      when(() => datasource.accomodateCache(cache)).thenAnswer((_) async => true);

      final response = await sut.accomodateCache(cache);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), isTrue);
      verify(() => datasource.accomodateCache(cache)).called(1);
    });

    test('should NOT be able to verify if can accomodate cache when datasource fails', () async {
      when(() => datasource.accomodateCache(cache)).thenThrow(FakeAutoCacheException());

      final response = await sut.accomodateCache(cache);

      expect(response.isError, isTrue);
      verify(() => datasource.accomodateCache(cache)).called(1);
    });
  });
}
