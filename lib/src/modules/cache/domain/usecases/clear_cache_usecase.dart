import '../../../../core/core.dart';
import '../dtos/clear_cache_dto.dart';
import '../repositories/i_cache_repository.dart';

abstract interface class ClearCacheUsecase {
  Future<Either<AutoCacheManagerException, Unit>> clear(ClearCacheDTO dto);
}

class ClearCache implements ClearCacheUsecase {
  final ICacheRepository _repository;

  const ClearCache(this._repository);

  @override
  Future<Either<AutoCacheManagerException, Unit>> clear(ClearCacheDTO dto) async {
    return _repository.clear(dto);
  }
}
