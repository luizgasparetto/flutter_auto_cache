import '../../../../core/core.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/save_cache_dto.dart';
import '../entities/cache_entity.dart';
import '../repositories/i_cache_repository.dart';
import '../services/invalidation_service/invalidation_cache_context.dart';

abstract interface class SaveCacheUsecase {
  AsyncEither<AutoCacheError, Unit> execute<T extends Object>(SaveCacheDTO<T> dto);
}

class SaveCache implements SaveCacheUsecase {
  final ICacheRepository _repository;
  final IInvalidationCacheContext _invalidationCacheContext;

  const SaveCache(this._repository, this._invalidationCacheContext);

  @override
  AsyncEither<AutoCacheError, Unit> execute<T extends Object>(SaveCacheDTO<T> dto) async {
    final findByKeyDto = GetCacheDTO(key: dto.key);
    final findByKeyResponse = _repository.get<T>(findByKeyDto);

    return findByKeyResponse.fold(left, (cache) async => _saveCache(cache, dto));
  }

  AsyncEither<AutoCacheError, Unit> _saveCache<T extends Object>(CacheEntity<T>? cache, SaveCacheDTO<T> dto) async {
    final validateResponse = _validate(cache);
    return validateResponse.fold(left, (_) async => _repository.save(dto));
  }

  Either<AutoCacheError, Unit> _validate<T extends Object>(CacheEntity<T>? cache) {
    if (cache == null) return right(unit);

    return _invalidationCacheContext.execute(cache);
  }
}
