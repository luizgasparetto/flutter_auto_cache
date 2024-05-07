import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/repositories/i_cache_repository.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/usecases/clear_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements ICacheRepository {}

class AutoCacheManagerExceptionFake extends Fake implements AutoCacheManagerException {}

void main() {
  final repository = CacheRepositoryMock();
  final sut = ClearCache(repository);

  tearDown(() {
    reset(repository);
  });

  group('ClearCache |', () {
    test('should be able to clear cache successfully', () async {
      when(() => repository.clear()).thenAnswer((_) async => right(unit));

      final response = await sut.execute();

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => repository.clear()).called(1);
    });

    test('should NOT be able to clear cache when repository fails', () async {
      when(() => repository.clear()).thenAnswer((_) async => left(AutoCacheManagerExceptionFake()));

      final response = await sut.execute();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => repository.clear()).called(1);
    });
  });
}
