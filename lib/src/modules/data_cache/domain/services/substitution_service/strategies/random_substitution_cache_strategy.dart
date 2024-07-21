part of '../substitution_cache_strategy.dart';

final class RandomSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const RandomSubstitutionCacheStrategy(super.dataRepository, super.substituteRepository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) {
    final keysResponse = this.getCacheKey();
    return keysResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    final keysResponse = substituteRepository.getKeys();
    return keysResponse.mapRight(_generateCacheKey);
  }

  String _generateCacheKey(List<String> keys) {
    final randomIndex = Random().nextInt(keys.length);
    return keys[randomIndex];
  }
}
