import 'package:flutter_auto_cache/src/modules/data_cache/domain/factories/data_cache_factory.dart';

import '../../../../core/errors/auto_cache_error.dart';
import '../../../../core/functional/either.dart';
import '../../../../core/extensions/types/type_extensions.dart';

import '../../../../core/infrastructure/protocols/cache_response.dart';
import '../dtos/key_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_service.dart';

typedef GetDataCacheResponse<T extends Object> = AsyncEither<AutoCacheError, CacheResponse<T?>>;

typedef InternalDataCacheResponse<T extends Object> = AsyncEither<AutoCacheError, DataCacheEntity<T>?>;

/// An interface defining the use case for retrieving data from the cache.
///
/// This use case provides a method to execute cache retrieval operations,
/// returning either an error or the cached data entity. It ensures the
/// retrieval and validation of cached data based on specified criteria.
abstract interface class IGetDataCacheUsecase {
  /// Executes the use case for retrieving a cached data entity based on the provided criteria.
  ///
  /// The method attempts to retrieve a cached entity that matches the criteria specified
  /// in the data transfer object (DTO). If successful, it returns the cached entity; otherwise,
  /// it returns an error.
  GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(KeyCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _repository;
  final IInvalidationCacheService _invalidationService;
  final IDataCacheFactory _dataCacheFactory;

  const GetDataCacheUsecase(this._repository, this._invalidationService, this._dataCacheFactory);

  @override
  GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(KeyCacheDTO dto) async {
    final response = await getCacheResponse<T, DataType>(dto);

    return response.fold(left, validateCacheResponse);
  }

  InternalDataCacheResponse<T> getCacheResponse<T extends Object, DataType extends Object>(KeyCacheDTO dto) async {
    if (T.isList) return _repository.getList<T, DataType>(dto);

    return _repository.get<T>(dto);
  }

  GetDataCacheResponse<T> validateCacheResponse<T extends Object>(DataCacheEntity<T>? cache) async {
    if (cache == null) return right(NotFoundCacheResponse());

    final response = _invalidationService.validate<T>(cache);
    return response.fold(left, (isValid) => handleValidateResponse<T>(isValid, cache));
  }

  GetDataCacheResponse<T> handleValidateResponse<T extends Object>(bool isValid, DataCacheEntity<T> cache) async {
    if (isValid) return updateUsageCount(cache);

    final response = await _repository.delete(KeyCacheDTO(key: cache.id));
    return response.mapRight((_) => ExpiredCacheResponse());
  }

  GetDataCacheResponse<T> updateUsageCount<T extends Object>(DataCacheEntity<T> cache) async {
    final usedCache = _dataCacheFactory.used<T>(cache);
    final response = await _repository.write(usedCache);

    return response.mapRight((_) => SuccessCacheResponse(data: cache.data));
  }
}
