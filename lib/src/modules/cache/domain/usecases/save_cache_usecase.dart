import '../../../../core/core.dart';
import '../dtos/save_cache_dto.dart';
import '../repositories/i_cache_repository.dart';

abstract interface class SaveCacheUsecase {
  Future<Either<AutoCacheManagerException, Unit>> execute<T>(SaveCacheDTO<T> dto);
}

class SaveCache implements SaveCacheUsecase {
  final ICacheRepository _repository;

  const SaveCache(this._repository);

  @override
  Future<Either<AutoCacheManagerException, Unit>> execute<T>(SaveCacheDTO<T> dto) async {
    final isKeyExisting = throw UnimplementedError();
  }
}


///Busca pela key
///Se não existir nada, salvar no cache
///Se já existir, verificar método de invalidação/substituição
///Se for refresh, atualizar o cache baseado na key
///Se for TTL, dar throw em erro dizendo que a key já é utilizada
