import '../../../../core/core.dart';

import '../dtos/clear_cache_dto.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/save_cache_dto.dart';
import '../entities/cache_entity.dart';

abstract interface class ICacheRepository {
  AsyncEither<AutoCacheManagerException, CacheEntity<T>?> get<T extends Object>(GetCacheDTO dto);
  AsyncEither<AutoCacheManagerException, Unit> save<T extends Object>(SaveCacheDTO<T> dto);
  AsyncEither<AutoCacheManagerException, Unit> update<T extends Object>();
  AsyncEither<AutoCacheManagerException, Unit> clear(ClearCacheDTO dto);
}
