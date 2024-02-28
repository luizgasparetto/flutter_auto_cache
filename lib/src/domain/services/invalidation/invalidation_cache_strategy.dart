import '../../../core/core.dart';

import '../../entities/cache_entity.dart';

abstract class InvalidationCacheStrategy {
  Either<AutoCacheManagerException, Unit> validate<T>(CacheEntity<T> cache);
}
