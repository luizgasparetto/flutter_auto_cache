import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/get_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_context.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/get_data_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class InvalidationCacheContextMock extends Mock implements IInvalidationCacheContext {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

class CacheEntityFake<T extends Object> extends Fake implements CacheEntity<T> {}

class AutoCacheFailureFake extends Fake implements AutoCacheFailure {}

void main() {
  final repository = CacheRepositoryMock();
  final invalidationContext = InvalidationCacheContextMock();

  final sut = GetDataCacheUsecase(repository, invalidationContext);

  final cacheFake = CacheEntityFake<String>();

  setUp(() {
    registerFallbackValue(cacheFake);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationContext);
  });

  group('GetCache |', () {
    const dto = GetCacheDTO(key: 'my_key');

    final successCache = CacheEntity<String>(
      id: 'any_id',
      data: 'cache_data',
      invalidationType: InvalidationType.refresh,
      createdAt: DateTime.now(),
      endAt: DateTime.now(),
    );

    test('should be able to get data in cache successfully', () {
      when(() => repository.get<String>(dto)).thenReturn(right(successCache));
      when(() => invalidationContext.execute(successCache)).thenReturn(right(unit));

      final response = sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, successCache);
      verify(() => repository.get<String>(dto)).called(1);
      verify(() => invalidationContext.execute(successCache)).called(1);
    });

    test('should be able to get data in cache if data is NULL successfully', () {
      when(() => repository.get<String>(dto)).thenReturn(right(null));

      final response = sut.execute<String, String>(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(any<CacheEntity<String>>()));
    });

    test('should NOT be able to get data in cache when get retrives an exception', () async {
      when(() => repository.get<String>(dto)).thenReturn(left(FakeAutoCacheManagerException()));

      final response = sut.execute<String, String>(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.get<String>(dto)).called(1);
      verifyNever(() => invalidationContext.execute<String>(any<CacheEntity<String>>()));
    });

    test('should NOT be able to get data in cache when invalidation context retrives an exception', () {
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
