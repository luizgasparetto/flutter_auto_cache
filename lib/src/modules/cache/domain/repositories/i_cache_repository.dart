import '../../../../core/core.dart';

import '../dtos/save_cache_dto.dart';
import '../types/cache_types.dart';

abstract interface class ICacheRepository {
  Future<GetCacheResponse<T>> findByKey<T extends Object>(String key);
  Future<Either<AutoCacheManagerException, Unit>> save<T extends Object>(SaveCacheDTO<T> dto);
}
