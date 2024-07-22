part of '../substitution_cache_strategy.dart';

final class LruSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  LruSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  final mementoDataCache = AutoCacheNotifier<List<DataCacheEntity>>([]);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) {
    final keysResponse = this.getCacheKey();
    return keysResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    return substitutionRepository.getKeys().mapRight((keys) => keys.first);
  }
}
