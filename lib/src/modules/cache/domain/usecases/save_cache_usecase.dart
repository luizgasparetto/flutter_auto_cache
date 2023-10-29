import 'dart:js_interop';

import '../../../../core/exceptions/cache_manager_exception.dart';
import '../../../../core/logic/either.dart';
import '../dtos/save_cache_dto.dart';
import '../repositories/i_cache_repository.dart';

abstract class ISaveCacheUsecase {
  Future<Either<AutoCacheManagerException, Unit>> execute<T>(
      SaveCacheDTO<T> dto);
}

class SaveCacheUsecase implements ISaveCacheUsecase {
  final ICacheRepository repository;

  const SaveCacheUsecase(this.repository);

  @override
  Future<Either<AutoCacheManagerException, Unit>> execute<T>(
      SaveCacheDTO<T> dto) async {
    final previousCacheItem = await this.repository.findById<T>(dto.id);

    if (previousCacheItem.isLeft) {
      return left(previousCacheItem.asLeft());
    }

    final successResponse = previousCacheItem.asRight();

    if (successResponse.isNull) {
      return this.repository.save(dto);
    }

    throw UnimplementedError();
  }
}
