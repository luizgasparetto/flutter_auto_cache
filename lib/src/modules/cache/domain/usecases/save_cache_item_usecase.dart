import '../../../../core/exceptions/cache_manager_exception.dart';
import '../../../../core/logic/either.dart';
import '../dtos/save_cache_dto.dart';
import '../exceptions/key_already_in_use_exception.dart';
import '../repositories/i_cache_repository.dart';

abstract class ISaveCacheItemUsecase {
  Future<Either<CacheManagerException, Unit>> execute(SaveCacheDTO dto);
}

class SaveCacheItemUsecase implements ISaveCacheItemUsecase {
  final ICacheRepository _repository;

  const SaveCacheItemUsecase(this._repository);

  @override
  Future<Either<CacheManagerException, Unit>> execute(SaveCacheDTO dto) async {
    final responseCached = await _repository.findById(dto.id);

    // if (isIdAlreadyInUse && dto.invalidationTypes.isNotSubstitute) {
    //   return left(KeyAlreadyInUseException());
    // }

    // TODO: implement execute
    throw UnimplementedError();
  }
}








///Ver se o item do cache já existe pelo id (key)
///Se o cache já existir e o método se substituição n seja purge, erro de key inválida

///Se o item em cache não existir, apenas salva-lo