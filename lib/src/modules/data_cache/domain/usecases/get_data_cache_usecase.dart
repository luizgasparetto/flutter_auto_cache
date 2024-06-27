import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_context.dart';

abstract interface class IGetDataCacheUsecase {
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _repository;
  final IInvalidationCacheContext _invalidationContext;

  const GetDataCacheUsecase(this._repository, this._invalidationContext);

  @override
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    final searchResponse = _getResponse<T, DataType>(dto);

    return searchResponse.fold(left, (cache) => _handleInvalidation(cache));
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _getResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    if (T.isList) return _repository.getList<T, DataType>(dto);

    return _repository.get<T>(dto);
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _handleInvalidation<T extends Object>(DataCacheEntity<T>? cache) {
    if (cache == null) return right(null);

    return _invalidationContext.execute<T>(cache).mapRight((_) => cache);
  }
}
