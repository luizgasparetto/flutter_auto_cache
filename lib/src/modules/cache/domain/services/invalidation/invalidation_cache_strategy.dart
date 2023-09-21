import '../../../../../core/logic/either.dart';
import '../../entities/cache_entity.dart';

abstract class InvalidationCacheStrategy {
  final CacheEntity cache;

  const InvalidationCacheStrategy(this.cache);

  Either<Exception, Unit> validate();
  bool get isCacheValid => validate().isRight;
}
