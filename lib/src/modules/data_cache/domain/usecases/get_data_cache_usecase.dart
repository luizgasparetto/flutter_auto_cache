import '../../../../core/core.dart';

import '../../../../core/functional/either.dart';
import '../../../../core/extensions/type_extensions.dart';

import '../dtos/key_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_service.dart';

typedef _GetDataCacheResponse<T extends Object> = AsyncEither<AutoCacheError, DataCacheEntity<T>?>;

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
  _GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(KeyCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _dataCacheRepository;
  final IInvalidationCacheService _invalidationCacheService;

  const GetDataCacheUsecase(this._dataCacheRepository, this._invalidationCacheService);

  @override
  _GetDataCacheResponse<T> execute<T extends Object, DataType extends Object>(KeyCacheDTO dto) async {
    final response = await _getResponse<T, DataType>(dto);

    return response.fold(left, _validateCacheResponse);
  }

  _GetDataCacheResponse<T> _getResponse<T extends Object, DataType extends Object>(KeyCacheDTO dto) async {
    if (T.isList) return _dataCacheRepository.getList<T, DataType>(dto);

    return _dataCacheRepository.get<T>(dto);
  }

  _GetDataCacheResponse<T> _validateCacheResponse<T extends Object>(DataCacheEntity<T>? cache) async {
    if (cache == null) return right(null);

    final response = _invalidationCacheService.validate<T>(cache);

    return response.fold(left, (isValid) => _handleValidateResponse(isValid, cache));
  }

  _GetDataCacheResponse<T> _handleValidateResponse<T extends Object>(bool isValid, DataCacheEntity<T> data) async {
    if (isValid) return right(data);

    final response = await _dataCacheRepository.delete(KeyCacheDTO(key: data.id));

    return response.mapRight((_) => null);
  }
}
