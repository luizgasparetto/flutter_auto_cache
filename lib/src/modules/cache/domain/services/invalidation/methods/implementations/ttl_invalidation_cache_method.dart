import '../../../../../../../core/core.dart';

import '../../../../entities/cache_entity.dart';
import '../invalidation_cache_method.dart';

class TTLInvalidationCacheMethod implements InvalidationCacheMethod {
  const TTLInvalidationCacheMethod._();

  static const TTLInvalidationCacheMethod _instance = TTLInvalidationCacheMethod._();

  static TTLInvalidationCacheMethod get I => _instance;

  @override
  Either<AutoCacheManagerException, Unit> execute<T extends Object>(CacheEntity<T> cache) {
    throw UnimplementedError();
  }
}
