import '../../../../core/core.dart';

import '../dtos/clear_cache_dto.dart';
import '../dtos/delete_cache_dto.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/save_cache_dto.dart';

import '../entities/cache_entity.dart';
import '../enums/storage_type.dart';

abstract interface class ICacheRepository {
  AsyncEither<AutoCacheManagerException, CacheEntity<T>?> get<T extends Object>(GetCacheDTO dto);
  AsyncEither<AutoCacheManagerException, List<String>> getKeys(StorageType storageType);

  AsyncEither<AutoCacheManagerException, Unit> save<T extends Object>(SaveCacheDTO<T> dto);
  AsyncEither<AutoCacheManagerException, Unit> update<T extends Object>();
  AsyncEither<AutoCacheManagerException, Unit> delete(DeleteCacheDTO dto);
  AsyncEither<AutoCacheManagerException, Unit> clear(ClearCacheDTO dto);
}
