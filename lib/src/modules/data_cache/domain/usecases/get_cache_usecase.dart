import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/cache_entity.dart';
import '../repositories/i_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_context.dart';

abstract interface class GetCacheUsecase {
  Either<AutoCacheError, CacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

class GetCache implements GetCacheUsecase {
  final ICacheRepository _repository;
  final IInvalidationCacheContext _invalidationContext;

  const GetCache(this._repository, this._invalidationContext);

  @override
  Either<AutoCacheError, CacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    final searchResponse = _getResponse<T, DataType>(dto);

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

  Either<AutoCacheError, CacheEntity<T>?> _getResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    if (T.isList) return _repository.getList<T, DataType>(dto);

    return _repository.get<T>(dto);
  }
}
