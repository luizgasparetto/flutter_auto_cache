import '../../../../../../core/core.dart';
import '../../../entities/data_cache_entity.dart';
import '../../../failures/invalidation_methods_failures.dart';
import '../invalidation_cache_strategy.dart';

final class TTLInvalidationCacheStrategy implements InvalidationCacheStrategy {
  @override
  Either<AutoCacheFailure, Unit> validate<T extends Object>(DataCacheEntity<T> cache) {
    final isExpired = cache.endAt.isBefore(DateTime.now());

    if (isExpired) return left(ExpiredTTLFailure());

    return right(unit);
  }
}
