import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/enums/storage_type.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/services/invalidation/invalidation_cache_context.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/infra/repositories/cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements CacheRepository {}

class InvalidationCacheContextMock extends Mock implements InvalidationCacheContext {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

class CacheEntityFake extends Fake implements CacheEntity {}

void main() {
  final repository = CacheRepositoryMock();
  final invalidationContext = InvalidationCacheContextMock();

  final sut = GetCache(repository, invalidationContext);

  final cacheFake = CacheEntityFake();

  setUp(() {
    registerFallbackValue(cacheFake);
  });

  tearDown(() {
    reset(repository);
    reset(invalidationContext);
  });

  group('GetCache |', () {
    final successCache = CacheEntity<String>(
      id: 'any_id',
      data: 'cache_data',
      storageType: StorageType.kvs,
      invalidationType: InvalidationType.refresh,
    );

    test('should be able to get data in cache successfully', () async {
      when(() => repository.findByKey<String>('my_key')).thenAnswer((_) async {
        return right(successCache);
      });

      when(() => invalidationContext.execute(successCache)).thenAnswer((_) {
        return right(unit);
      });

      final response = await sut.execute<String>(key: 'my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, successCache);
      verify(() => repository.findByKey<String>('my_key')).called(1);
      verify(() => invalidationContext.execute(successCache)).called(1);
    });

    test('should be able to get data in cache if data is NULL successfully', () async {
      when(() => repository.findByKey<String>('my_key')).thenAnswer((_) async {
        return right(null);
      });

      final response = await sut.execute<String>(key: 'my_key');

      expect(response.isSuccess, isTrue);
      expect(response.success, isNull);
      verify(() => repository.findByKey<String>('my_key')).called(1);
      verifyNever(() => invalidationContext.execute<String>(any()));
    });

    test('should NOT be able to get data in cache when findByKey retrives an exception', () async {
      when(() => repository.findByKey<String>('my_key')).thenAnswer((_) async {
        return left(FakeAutoCacheManagerException());
      });

      final response = await sut.execute<String>(key: 'my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => repository.findByKey<String>('my_key')).called(1);
      verifyNever(() => invalidationContext.execute<String>(any()));
    });

    test('should NOT be able to get data in cache when invalidation context retrives an exception', () async {
      when(() => repository.findByKey<String>('my_key')).thenAnswer((_) async {
        return right(successCache);
      });

      when(() => invalidationContext.execute(successCache)).thenAnswer((_) {
        return left(FakeAutoCacheManagerException());
      });

      final response = await sut.execute<String>(key: 'my_key');

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => repository.findByKey<String>('my_key')).called(1);
      verify(() => invalidationContext.execute(successCache)).called(1);
    });
  });
}
