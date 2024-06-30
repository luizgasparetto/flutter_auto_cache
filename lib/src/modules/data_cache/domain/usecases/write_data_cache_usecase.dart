import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';

import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/update_cache_dto.dart';
import '../dtos/write_cache_dto.dart';
import '../entities/data_cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_service.dart';

/// Type definition for the response of the write data cache operation.
///
/// This type represents an asynchronous operation result, which can either be
/// an [AutoCacheError] in case of failure, or a [Unit] in case of success.
typedef WriteDataCacheResponse = AsyncEither<AutoCacheError, Unit>;

typedef _SubstituteCallback = AsyncEither<AutoCacheError, Unit> Function();

/// Interface for writing data to the cache.
///
/// This interface defines a method for writing data to the cache based on the
/// provided [WriteCacheDTO] data transfer object. The operation returns an
/// `AsyncEither` type that represents either an [AutoCacheError] in case of
/// failure, or a [Unit] in case of success.
abstract interface class IWriteDataCacheUsecase {
  /// Writes data to the cache based on the provided [dto].
  ///
  /// This method is asynchronous and returns a `WriteDataCacheResponse` which is a type
  /// representing a computation that can either result in an `AutoCacheError`
  /// (in case of failure) or a [Unit] (in case of success). The [dto] parameter
  /// encapsulates the necessary information for the cache data to be written.
  WriteDataCacheResponse execute<T extends Object>(WriteCacheDTO<T> dto);
}

final class WriteDataCacheUsecase implements IWriteDataCacheUsecase {
  final IDataCacheRepository _repository;
  final ISubstitutionCacheService _substitutionService;
  final IInvalidationCacheContext _invalidationCacheContext;

  const WriteDataCacheUsecase(this._repository, this._substitutionService, this._invalidationCacheContext);

  @override
  WriteDataCacheResponse execute<T extends Object>(WriteCacheDTO<T> dto) async {
    final findByKeyDto = GetCacheDTO(key: dto.key);
    final findByKeyResponse = _repository.get<T>(findByKeyDto);

    return findByKeyResponse.fold(left, (cache) async => _validateCache(cache, dto));
  }

  // TODO(Luiz): Add status de invalidação, n faz sentido escrever na failure
  WriteDataCacheResponse _validateCache<T extends Object>(DataCacheEntity<T>? cache, WriteCacheDTO<T> dto) async {
    if (cache == null) return _substituteDataCache<T>(dto.data, () => _repository.save(dto));

    final validateResponse = _invalidationCacheContext.execute(cache);

    return validateResponse.fold((failure) => _writeExpiredCache(dto, failure), (_) => _updateDataCache(cache, dto));
  }

  WriteDataCacheResponse _writeExpiredCache<T extends Object>(WriteCacheDTO<T> dto, AutoCacheFailure failure) async {
    if (!dto.cacheConfig.dataCacheOptions.replaceExpiredCache) return left(failure);

    return _substituteDataCache<T>(dto.data, () => _repository.save(dto));
  }

  WriteDataCacheResponse _updateDataCache<T extends Object>(DataCacheEntity<T> cache, WriteCacheDTO<T> dto) async {
    final updateDTO = UpdateCacheDTO<T>(previewCache: cache, config: dto.cacheConfig);

    return _substituteDataCache<T>(dto.data, () => _repository.update(updateDTO));
  }

  WriteDataCacheResponse _substituteDataCache<T extends Object>(T data, _SubstituteCallback callback) async {
    final response = await _substitutionService.substitute(data);

    return response.fold(left, (_) => callback());
  }
}
