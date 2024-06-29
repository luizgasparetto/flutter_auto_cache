import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_context.dart';

typedef GetDataCacheResponse<T extends Object> = AsyncEither<AutoCacheError, DataCacheEntity<T>?>;

abstract interface class IGetDataCacheUsecase {
  GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _dataCacheRepository;
  final IInvalidationCacheContext _invalidationContext;

  const GetDataCacheUsecase(this._dataCacheRepository, this._invalidationContext);

  @override
  GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) async {
    final response = await _getResponse<T, DataType>(dto);

    return response.fold(left, (cache) => _validateCacheResponse(cache));
  }

  GetDataCacheResponse<T> _getResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) async {
    if (T.isList) return _dataCacheRepository.getList<T, DataType>(dto);

    return _dataCacheRepository.get<T>(dto);
  }

  GetDataCacheResponse<T> _validateCacheResponse<T extends Object>(DataCacheEntity<T>? cache) async {
    if (cache == null) return right(null);

    return _invalidationContext.execute<T>(cache).mapRight((_) => cache);
  }
}
