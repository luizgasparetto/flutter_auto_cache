import '../../../../core/core.dart';

import '../dtos/save_cache_dto.dart';
import '../entities/cache_entity.dart';

abstract interface class ICacheRepository {
  Future<Either<AutoCacheManagerException, CacheEntity<T>?>> findByKey<T>(String key);
  Future<Either<AutoCacheManagerException, Unit>> save<T>(SaveCacheDTO<T> dto);
}
