import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/functional/either.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/clear_data_cache_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class AutoCacheExceptionFake extends Fake implements AutoCacheException {}

void main() {
  final repository = CacheRepositoryMock();
  final sut = ClearDataCacheUsecase(repository);

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
      when(() => repository.clear()).thenAnswer((_) async => left(AutoCacheExceptionFake()));

      final response = await sut.execute();

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.clear()).called(1);
    });
  });
}
