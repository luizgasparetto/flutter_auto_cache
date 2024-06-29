import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_types.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_substitution_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_context.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/get_data_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataCacheRepositoryMock extends Mock implements IDataCacheRepository {}

class SubstitutionDataCacheRepositoryMock extends Mock implements ISubstitutionDataCacheRepository {}

class InvalidationCacheContextMock extends Mock implements IInvalidationCacheContext {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

class DataCacheEntityFake<T extends Object> extends Fake implements DataCacheEntity<T> {}

class AutoCacheFailureFake extends Fake implements AutoCacheFailure {}

void main() {
  final repository = DataCacheRepositoryMock();
  final substitutionRepository = SubstitutionDataCacheRepositoryMock();
  final invalidationContext = InvalidationCacheContextMock();

  final sut = GetDataCacheUsecase(repository, invalidationContext);

  final cacheFake = DataCacheEntityFake<String>();

  setUp(() {
    registerFallbackValue(cacheFake);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationContext);
    reset(substitutionRepository);
  });

  group('GetCache |', () {
    const dto = GetCacheDTO(key: 'my_key');

    final successCache = DataCacheEntity<String>(
      id: 'any_id',
      data: 'cache_data',
      invalidationType: InvalidationTypes.refresh,
      createdAt: DateTime.now(),
      endAt: DateTime.now(),
    );

    test('should be able to get data in cache successfully', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(successCache));
      when(() => invalidationContext.execute(successCache)).thenReturn(right(unit));

      final response = sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, successCache);
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationContext.execute(successCache)).called(1);
    });

    test('should be able to get data in cache if data is NULL successfully', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(null));

      final response = sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(any<DataCacheEntity<String>>()));
    });

    test('should NOT be able to get data in cache when get retrives an exception', () async {
      when(() => repository.get<String>(dto)).thenReturn(left(FakeAutoCacheManagerException()));

      final response = await sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(any<DataCacheEntity<String>>()));
    });

    test('should NOT be able to get data in cache when invalidation context retrives an exception', () async {
      when(() => repository.get<String>(dto)).thenReturn(right(successCache));
      when(() => invalidationContext.execute(successCache)).thenReturn(left(AutoCacheFailureFake()));

      final response = sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheFailure>());
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationContext.execute(successCache)).called(1);
    });
  });
}
