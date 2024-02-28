import '../../core/core.dart';

import '../entities/cache_entity.dart';

typedef GetCacheResponseType<T> = Future<Either<AutoCacheManagerException, CacheEntity<T>?>>;
typedef SaveCacheResponseType = Future<Either<AutoCacheManagerException, Unit>>;
