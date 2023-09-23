import '../../../../core/exceptions/cache_manager_exception.dart';
import '../../../../core/logic/either.dart';
import '../dtos/save_cache_dto.dart';
import '../repositories/i_cache_repository.dart';

abstract class ISaveCacheItemUsecase {
  Future<Either<AutoCacheManagerException, Unit>> execute(SaveCacheDTO dto);
}

class SaveCacheItemUsecase implements ISaveCacheItemUsecase {
  final ICacheRepository _repository;

  const SaveCacheItemUsecase(this._repository);

  @override
  Future<Either<AutoCacheManagerException, Unit>> execute(SaveCacheDTO dto) async {
    final responseCached = await _repository.findById(dto.id);

    // if (isIdAlreadyInUse && dto.invalidationTypes.isNotSubstitute) {
    //   return left(KeyAlreadyInUseException());
    // }

    // TODO: implement execute
    throw UnimplementedError();
  }
}


///Busca pela key
///Se não existir nada, salvar no cache
///Se já existir, verificar método de invalidação/substituição
///Se for refresh, atualizar o cache baseado na key
///Se for TTL, dar throw em erro dizendo que a key já é utilizada
