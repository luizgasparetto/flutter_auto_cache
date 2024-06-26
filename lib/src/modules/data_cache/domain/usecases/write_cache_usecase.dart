import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/update_cache_dto.dart';
import '../dtos/write_cache_dto.dart';
import '../entities/cache_entity.dart';
import '../repositories/i_data_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_context.dart';

typedef WriteCacheResponse = AsyncEither<AutoCacheError, Unit>;

abstract interface class IWriteCacheUsecase {
  WriteCacheResponse execute<T extends Object>(WriteCacheDTO<T> dto);
}

final class WriteCacheUsecase implements IWriteCacheUsecase {
  final IDataCacheRepository _repository;
  final IInvalidationCacheContext _invalidationCacheContext;

  const WriteCacheUsecase(this._repository, this._invalidationCacheContext);

  @override
  WriteCacheResponse execute<T extends Object>(WriteCacheDTO<T> dto) async {
    final findByKeyDto = GetCacheDTO(key: dto.key);
    final findByKeyResponse = _repository.get<T>(findByKeyDto);

    return findByKeyResponse.fold(left, (cache) async => _validateCache(cache, dto));
  }

  WriteCacheResponse _validateCache<T extends Object>(CacheEntity<T>? cache, WriteCacheDTO<T> dto) async {
    if (cache == null) return _repository.save(dto);

    final validateResponse = _invalidationCacheContext.execute(cache);

    return validateResponse.fold((failure) => _writeExpiredCache(dto, failure), (_) => _updateCache(cache, dto));
  }

  WriteCacheResponse _writeExpiredCache<T extends Object>(WriteCacheDTO<T> dto, AutoCacheFailure failure) async {
    if (!dto.cacheConfig.replaceExpiredCache) return left(failure);

    return _repository.save(dto);
  }

  WriteCacheResponse _updateCache<T extends Object>(CacheEntity<T> cache, WriteCacheDTO<T> dto) async {
    final updateDTO = UpdateCacheDTO<T>(previewCache: cache, config: dto.cacheConfig);

    return _repository.update(updateDTO);
  }
}
