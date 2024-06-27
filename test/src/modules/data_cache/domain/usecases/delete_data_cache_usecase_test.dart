import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/delete_cache_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/usecases/delete_data_cache_usecase.dart';

class CacheRepositoryMock extends Mock implements IDataCacheRepository {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

void main() {
  final repository = CacheRepositoryMock();
  final sut = DeleteDataCacheUsecase(repository);

  tearDown(() {
    reset(repository);
  });

  group('DeleteCache |', () {
    const dto = DeleteCacheDTO(key: 'my_key');

    test('should be able to delete cache by key successfully', () async {
      when(() => repository.delete(dto)).thenAnswer((_) async => right(unit));

      final response = await sut.execute(dto);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
      verify(() => repository.delete(dto)).called(1);
    });

    test('should NOT be able to delete cache by key when repository fails', () async {
      when(() => repository.delete(dto)).thenAnswer((_) async => left(FakeAutoCacheManagerException()));

      final response = await sut.execute(dto);

      expect(response.isError, isTrue);
      expect(response.error, isA<AutoCacheException>());
      verify(() => repository.delete(dto)).called(1);
    });
  });
}
