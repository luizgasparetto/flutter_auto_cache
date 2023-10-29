import '../../../../core/core.dart';

import '../dtos/save_cache_dto.dart';
import '../entities/cache_entity.dart';

abstract class ICacheRepository {
  Future<Either<AutoCacheManagerException, CacheEntity<T>?>> findById<T>(String key);
  Future<Either<AutoCacheManagerException, Unit>> save(SaveCacheDTO dto);
}
