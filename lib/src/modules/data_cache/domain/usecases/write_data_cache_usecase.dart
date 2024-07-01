import '../../../../core/core.dart';
import '../../../../core/functional/either.dart';

import '../dtos/get_cache_dto.dart';
import '../dtos/update_cache_dto.dart';
import '../dtos/write_cache_dto.dart';

import '../entities/data_cache_entity.dart';

import '../repositories/i_data_cache_repository.dart';

import '../services/invalidation_service/invalidation_cache_service.dart';
import '../services/substitution_service/substitution_cache_service.dart';

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
  AsyncEither<AutoCacheError, Unit> execute<T extends Object>(WriteCacheDTO<T> dto);
}

final class WriteDataCacheUsecase implements IWriteDataCacheUsecase {
  final IDataCacheRepository _repository;
  final ISubstitutionCacheService _substitutionService;
  final IInvalidationCacheService _invalidationCacheService;

  const WriteDataCacheUsecase(this._repository, this._substitutionService, this._invalidationCacheService);

  @override
  AsyncEither<AutoCacheError, Unit> execute<T extends Object>(WriteCacheDTO<T> dto) async {
    final getCacheDto = GetCacheDTO(key: dto.key);
    final getResponse = _repository.get<T>(getCacheDto);

    return getResponse.fold(left, (cache) => _validateCache(cache, dto));
  }

  AsyncEither<AutoCacheError, Unit> _validateCache<T extends Object>(DataCacheEntity<T>? cache, WriteCacheDTO<T> dto) async {
    if (cache == null) return _saveCache<T>(dto);

    final validateResponse = _invalidationCacheService.validate(cache);

    return validateResponse.fold(left, (isValid) => isValid ? _updateCache<T>(cache, dto) : _saveCache<T>(dto));
  }

  AsyncEither<AutoCacheError, Unit> _saveCache<T extends Object>(WriteCacheDTO<T> dto) async {
    final response = await _substitutionService.substitute(dto.data);

    return response.fold(left, (_) => _repository.save<T>(dto));
  }

  AsyncEither<AutoCacheError, Unit> _updateCache<T extends Object>(DataCacheEntity<T> cache, WriteCacheDTO<T> dto) async {
    final updateDTO = UpdateCacheDTO<T>(previewCache: cache, config: dto.cacheConfig);
    final response = await _substitutionService.substitute(dto.data);

    return response.fold(left, (_) => _repository.update<T>(updateDTO));
  }
}
