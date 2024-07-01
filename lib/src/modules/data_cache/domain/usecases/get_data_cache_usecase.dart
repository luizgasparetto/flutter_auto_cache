import '../../../../core/core.dart';

import '../../../../core/functional/either.dart';
import '../../../../core/extensions/type_extensions.dart';

import '../dtos/get_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_service.dart';

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
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto);
}

final class GetDataCacheUsecase implements IGetDataCacheUsecase {
  final IDataCacheRepository _dataCacheRepository;
  final IInvalidationCacheService _invalidationCacheService;

  const GetDataCacheUsecase(this._dataCacheRepository, this._invalidationCacheService);

  @override
  Either<AutoCacheError, DataCacheEntity<T>?> execute<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    final response = _getResponse<T, DataType>(dto);

    return response.fold(left, _validateCacheResponse);
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _getResponse<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    if (T.isList) return _dataCacheRepository.getList<T, DataType>(dto);

    return _dataCacheRepository.get<T>(dto);
  }

  Either<AutoCacheError, DataCacheEntity<T>?> _validateCacheResponse<T extends Object>(DataCacheEntity<T>? cache) {
    if (cache == null) return right(null);

    final response = _invalidationCacheService.validate<T>(cache);

    return response.mapRight((isValid) => isValid ? cache : null);
  }
}
