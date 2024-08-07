part of '../data_cache_substitution_strategy.dart';

final class LruSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  LruSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  final dataCacheEntries = AutoCacheNotifier<List<DataCacheEntity>>([]);

  @override
  Either<AutoCacheError, String> getCacheKey({bool recursive = false}) {
    if (dataCacheEntries.value.isEmpty) return _getAllEntries();
    if (recursive) _removeFirstDataCacheEntrie();

    return right(dataCacheEntries.value.first.id);
  }

  void _removeFirstDataCacheEntrie() {
    final updatedCacheList = dataCacheEntries.value.removeFirst();
    dataCacheEntries.setData(updatedCacheList);
  }

  Either<AutoCacheError, String> _getAllEntries() {
    final cacheEntriesResponse = substitutionRepository.getAll();
    return cacheEntriesResponse.fold(left, _callbackGetCacheKey);
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
