import '../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../core/shared/functional/either.dart';
import '../dtos/key_cache_dto.dart';
import '../dtos/write_cache_dto.dart';

import '../entities/data_cache_entity.dart';

import '../factories/data_cache_factory.dart';
import '../repositories/i_data_cache_repository.dart';

import '../services/invalidation_service/invalidation_cache_service.dart';
import '../services/substitution_service/substitution_cache_service.dart';

typedef WriteDataCacheResponse = AsyncEither<AutoCacheError, Unit>;

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
  final IInvalidationCacheService _invalidationService;
  final IDataCacheFactory _cacheFactory;

  const WriteDataCacheUsecase(this._repository, this._substitutionService, this._invalidationService, this._cacheFactory);

  @override
  WriteDataCacheResponse execute<T extends Object>(WriteCacheDTO<T> dto) async {
    final keyDto = KeyCacheDTO(key: dto.key);
    final getResponse = _repository.get<T>(keyDto);

    return getResponse.fold(left, (cache) => validateDataCache(cache, dto));
  }

  WriteDataCacheResponse validateDataCache<T extends Object>(DataCacheEntity<T>? cache, WriteCacheDTO<T> dto) async {
    if (cache == null) return saveCache<T>(dto);

    final validateResponse = _invalidationService.validate(cache);

    return validateResponse.fold(left, (isValid) => isValid ? updateCache<T>(dto.data, cache) : saveCache<T>(dto));
  }

  WriteDataCacheResponse saveCache<T extends Object>(WriteCacheDTO<T> dto) async {
    final saveCache = _cacheFactory.save<T>(dto);
    final response = await _substitutionService.substitute(saveCache.data);

    return response.fold(left, (_) => _repository.write<T>(saveCache));
  }

  WriteDataCacheResponse updateCache<T extends Object>(T data, DataCacheEntity<T> cache) async {
    final updateCache = _cacheFactory.update<T>(data, cache);
    final response = await _substitutionService.substitute(updateCache.data);

    return response.fold(left, (_) => _repository.write<T>(updateCache));
  }
}
