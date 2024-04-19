import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../repositories/i_cache_repository.dart';
import '../services/invalidation/invalidation_cache_context.dart';
import '../types/cache_types.dart';

abstract class GetCacheUsecase {
  Future<GetCacheResponse<T>> execute<T extends Object>(GetCacheDTO dto);
}

class GetCache implements GetCacheUsecase {
  final ICacheRepository _repository;
  final IInvalidationCacheContext _invalidationContext;

  const GetCache(this._repository, this._invalidationContext);

  @override
  Future<GetCacheResponse<T>> execute<T extends Object>(GetCacheDTO dto) async {
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
