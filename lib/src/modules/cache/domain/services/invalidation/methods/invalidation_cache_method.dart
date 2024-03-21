import '../../../../../../core/core.dart';
import '../../../entities/cache_entity.dart';

abstract class InvalidationCacheMethod {
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache);
}
