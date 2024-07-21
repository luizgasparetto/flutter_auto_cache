part of '../substitution_cache_strategy.dart';

final class FifoSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const FifoSubstitutionCacheStrategy(super.dataRepository, super.substituteRepository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) async {
    final keysResponse = this.getCacheKey();
    return keysResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    final keysResponse = substituteRepository.getKeys();
    return keysResponse.mapRight((keys) => keys.first);
  }
}
