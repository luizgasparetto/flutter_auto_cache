import '../../../../../../core/core.dart';
import '../substitution_cache_strategy.dart';

final class FifoSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const FifoSubstitutionCacheStrategy(super.repository, super.sizeService);

  @override
  AsyncEither<AutoCacheError, Unit> substitute(String value, SubstitutionCallback callback) async {
    final keysResponse = this.getCacheKey();
    return keysResponse.fold(left, (key) => super.deleteDataCache(key, value, callback));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    final keysResponse = repository.getKeys();
    return keysResponse.mapRight((keys) => keys.first);
  }
}
