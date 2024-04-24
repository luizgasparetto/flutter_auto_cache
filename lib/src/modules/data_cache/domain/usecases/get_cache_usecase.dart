import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/cache_entity.dart';
import '../repositories/i_cache_repository.dart';
import '../services/invalidation/invalidation_cache_context.dart';

abstract class GetCacheUsecase {
  AsyncEither<AutoCacheManagerException, CacheEntity<T>?> execute<T extends Object>(GetCacheDTO dto);
}

class GetCache implements GetCacheUsecase {
  final ICacheRepository _repository;
  final IInvalidationCacheContext _invalidationContext;

  const GetCache(this._repository, this._invalidationContext);

  @override
  AsyncEither<AutoCacheManagerException, CacheEntity<T>?> execute<T extends Object>(GetCacheDTO dto) async {
    final searchResponse = await _repository.get<T>(dto);

    if (searchResponse.isError) {
      return left(searchResponse.error);
    }

    if (searchResponse.isSuccess && searchResponse.success == null) {
      return right(null);
    }

    final cache = searchResponse.success!;
    final validation = _invalidationContext.execute(cache);

    if (validation.isError) {
      return left(validation.error);
    }

    return right(cache);
  }
}
