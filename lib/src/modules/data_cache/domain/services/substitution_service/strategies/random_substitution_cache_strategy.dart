part of '../substitution_cache_strategy.dart';

final class RandomSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const RandomSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) {
    final keyResponse = this.getCacheKey();
    return keyResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    final keysResponse = substitutionRepository.getKeys();
    return keysResponse.mapRight(_generateCacheKey);
  }

  String _generateCacheKey(List<String> keys) {
    final randomIndex = Random().nextInt(keys.length);
    return keys[randomIndex];
  }
}
