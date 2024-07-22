part of '../substitution_cache_strategy.dart';

final class LruSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  LruSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  final dataCacheEntries = AutoCacheNotifier<List<DataCacheEntity>>([]);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value) {
    final keyResponse = this.getCacheKey();
    return keyResponse.fold(left, (key) => super.deleteDataCache<T>(key, value));
  }

  @override
  Either<AutoCacheError, String> getCacheKey() {
    if (dataCacheEntries.value.isEmpty) {
      final cacheEntriesResponse = substitutionRepository.getAll();
      return cacheEntriesResponse.fold(left, _callbackGetCacheKey);
    }

    return right(dataCacheEntries.value.first.id);
  }

  @override
  AsyncEither<AutoCacheError, Unit> deleteDataCache<T extends Object>(String key, DataCacheEntity<T> data) {
    final updatedCacheList = dataCacheEntries.value.removeFirst();
    dataCacheEntries.setData(updatedCacheList);

    return super.deleteDataCache(key, data);
  }

  Either<AutoCacheError, String> _callbackGetCacheKey(List<DataCacheEntity?> entries) {
    final sortedList = _sortDataCacheEntries(entries: entries);
    dataCacheEntries.setData(sortedList);

    return this.getCacheKey();
  }

  List<DataCacheEntity> _sortDataCacheEntries({required List<DataCacheEntity?> entries}) {
    final cacheList = entries.whereType<DataCacheEntity>().toList();
    return cacheList.sorted((a, b) => b.usageCount.compareTo(a.usageCount));
  }
}
