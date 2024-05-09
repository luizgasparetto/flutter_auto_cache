import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/cache_entity.dart';
import '../repositories/i_cache_repository.dart';
import '../services/invalidation/invalidation_cache_context.dart';

typedef GetCacheResponse<T extends Object> = AsyncEither<AutoCacheManagerException, CacheEntity<T>?>;

abstract class GetCacheUsecase {
  GetCacheResponse<T> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

class GetCache implements GetCacheUsecase {
  final ICacheRepository _repository;
  final IInvalidationCacheContext _invalidationContext;

  const GetCache(this._repository, this._invalidationContext);

  @override
  GetCacheResponse<T> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) async {
    final searchResponse = await _getSearchResponse<T, DataType>(dto);

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

  GetCacheResponse<T> _getSearchResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) async {
    if (T.isList) return _repository.getList<T, DataType>(dto);

    return _repository.get<T>(dto);
  }
}
