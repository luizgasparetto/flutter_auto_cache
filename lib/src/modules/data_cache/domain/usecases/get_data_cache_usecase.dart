import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_service.dart';

abstract interface class IGetDataCacheUsecase {
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _dataCacheRepository;
  final IInvalidationCacheContext _invalidationContext;

  const GetDataCacheUsecase(this._dataCacheRepository, this._invalidationContext);

  @override
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    final response = _getResponse<T, DataType>(dto);

    return response.fold(left, (cache) => _validateCacheResponse(cache));
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _getResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    if (T.isList) return _dataCacheRepository.getList<T, DataType>(dto);

    return _dataCacheRepository.get<T>(dto);
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _validateCacheResponse<T extends Object>(DataCacheEntity<T>? cache) {
    if (cache == null) return right(null);

    return _invalidationContext.execute<T>(cache).mapRight((_) => cache);
  }
}
