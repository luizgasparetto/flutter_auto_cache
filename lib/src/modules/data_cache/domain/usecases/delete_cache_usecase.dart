import '../../../../core/core.dart';

import '../dtos/delete_cache_dto.dart';
import '../repositories/i_data_cache_repository.dart';

abstract interface class DeleteCacheUsecase {
  AsyncEither<AutoCacheError, Unit> execute(DeleteCacheDTO dto);
}

class DeleteCache implements DeleteCacheUsecase {
  final IDataCacheRepository _repository;

  const DeleteCache(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> execute(DeleteCacheDTO dto) async {
    return _repository.delete(dto);
  }
}
