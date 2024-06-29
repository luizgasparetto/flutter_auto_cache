import '../../../domain/entities/data_cache_entity.dart';

abstract interface class ISubstitutionDataCacheDatasource {
  Future<void> updateCacheUsage<T extends Object>(DataCacheEntity<T> cache);
}
