part of '../data_cache_substitution_strategy.dart';

final class RandomSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  const RandomSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  @override
  Either<AutoCacheError, String> getCacheKey({bool recursive = false}) {
    final keysResponse = substitutionRepository.getKeys();
    return keysResponse.mapRight(_generateCacheKey);
  }

  String _generateCacheKey(List<String> keys) {
    final randomIndex = Random().nextInt(keys.length);
    return keys[randomIndex];
  }
}
