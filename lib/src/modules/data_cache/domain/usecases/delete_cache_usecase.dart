import '../../../../core/core.dart';

import '../dtos/delete_cache_dto.dart';
import '../repositories/i_cache_repository.dart';

abstract interface class DeleteCacheUsecase {
  AsyncEither<AutoCacheManagerException, Unit> execute(DeleteCacheDTO dto);
}

class DeleteCache implements DeleteCacheUsecase {
  final ICacheRepository _repository;

  const DeleteCache(this._repository);

  @override
  AsyncEither<AutoCacheManagerException, Unit> execute(DeleteCacheDTO dto) async {
    return _repository.delete(dto);
  }
}
