import '../../../../core/core.dart';
import '../entities/cache_entity.dart';

typedef GetCacheResponse<T extends Object> = Either<AutoCacheManagerException, CacheEntity<T>?>;
