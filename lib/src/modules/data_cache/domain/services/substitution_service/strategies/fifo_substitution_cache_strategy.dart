part of '../substitution_cache_strategy.dart';

final class FifoSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const FifoSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) async {
    final keyResponse = this.getCacheKey();
    return keyResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey({bool recursive = false}) {
    final keysResponse = substitutionRepository.getKeys();
    return keysResponse.mapRight((keys) => keys.first);
  }
}
