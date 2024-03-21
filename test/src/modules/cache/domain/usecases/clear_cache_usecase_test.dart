import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/dtos/clear_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/repositories/i_cache_repository.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/clear_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements ICacheRepository {}

class ClearCacheDTOFake extends Fake implements ClearCacheDTO {}

class AutoCacheManagerExceptionFake extends Fake implements AutoCacheManagerException {}

void main() {
  final repository = CacheRepositoryMock();
  final sut = ClearCache(repository);

  tearDown(() {
    reset(repository);
  });

  group('ClearCache |', () {
    final dto = ClearCacheDTOFake();

    test('should be able to clear cache successfully', () async {
      when(() => repository.clear(dto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => repository.clear(dto)).called(1);
    });

    test('should NOT be able to clear cache when repository fails', () async {
      when(() => repository.clear(dto)).thenAnswer((_) async {
        return left(AutoCacheManagerExceptionFake());
      });

      final response = await sut.execute(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheManagerException>());
      verify(() => repository.clear(dto)).called(1);
    });
  });
}
