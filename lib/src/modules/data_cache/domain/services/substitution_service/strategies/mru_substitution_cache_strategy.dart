part of '../data_cache_substitution_strategy.dart';

final class MruSubstitutionCacheStrategy extends ISubstitutionCacheStrategy {
  MruSubstitutionCacheStrategy(super.dataRepository, super.substitutionRepository);

  final dataCacheEntries = AutoCacheNotifier<List<DataCacheEntity>>([]);

  @override
  Either<AutoCacheError, String> getCacheKey({bool recursive = false}) {
    if (dataCacheEntries.value.isEmpty) {
      final cacheEntriesResponse = substitutionRepository.getAll();
      return cacheEntriesResponse.fold(left, _callbackGetCacheKey);
    }

    if (recursive) {
      final updatedCacheList = dataCacheEntries.value.removeFirst();
      dataCacheEntries.setData(updatedCacheList);
    }

    return right(dataCacheEntries.value.first.id);
  }

  Either<AutoCacheError, String> _callbackGetCacheKey(List<DataCacheEntity?> entries) {
    final sortedList = _sortDataCacheEntries(entries: entries);
    dataCacheEntries.setData(sortedList);

    return this.getCacheKey();
  }

  List<DataCacheEntity> _sortDataCacheEntries({required List<DataCacheEntity?> entries}) {
    final cacheList = entries.whereType<DataCacheEntity>().toList();
    final defaultTime = DateTime.fromMillisecondsSinceEpoch(0);

    return cacheList.sorted((a, b) => (b.metadata.usedAt ?? defaultTime).compareTo(a.metadata.usedAt ?? defaultTime));
  }
}
