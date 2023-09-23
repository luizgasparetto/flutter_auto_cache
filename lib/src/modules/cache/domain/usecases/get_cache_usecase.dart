import '../types/cache_types.dart';
import '../repositories/i_cache_repository.dart';

abstract class GetCacheUsecase<T> {
  GetCacheResponseType<T> execute({required String id});
}

class GetCache<T> implements GetCacheUsecase {
  final ICacheRepository _repository;

  const GetCache(this._repository);

  @override
  GetCacheResponseType<T> execute({required String id}) async {
    final foundCacheResponse = await _repository.findById(id);

    ///Busca pela key
    ///Se não achar -> erro de not found
    ///Se achar, executar método de invalidação
    ///Se invalidado, retornar error de cache não válido
    ///Se estiver válido, retornar item do cache

    // TODO: implement execute
    throw UnimplementedError();
  }
}
