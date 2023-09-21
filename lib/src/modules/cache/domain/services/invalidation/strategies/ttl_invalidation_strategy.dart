import '../../../../../../core/logic/either.dart';
import '../invalidation_cache_strategy.dart';

class TTLInvalidationStrategy extends InvalidationCacheStrategy {
  const TTLInvalidationStrategy(super.cache);

  @override
  Either<Exception, Unit> validate() {
    throw UnimplementedError();
  }
}
