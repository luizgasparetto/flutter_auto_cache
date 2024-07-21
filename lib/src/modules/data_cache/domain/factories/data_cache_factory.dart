import '../../../../../flutter_auto_cache.dart';
import '../dtos/write_cache_dto.dart';
import '../entities/data_cache_entity.dart';

abstract interface class IDataCacheFactory {
  DataCacheEntity<T> save<T extends Object>(WriteCacheDTO<T> dto);
  DataCacheEntity<T> update<T extends Object>(T data, DataCacheEntity<T> cache);
}

final class DataCacheFactory implements IDataCacheFactory {
  final CacheConfiguration configuration;

  const DataCacheFactory(this.configuration);

  @override
  DataCacheEntity<T> save<T extends Object>(WriteCacheDTO<T> dto) {
    return DataCacheEntity(
      id: dto.key,
      data: dto.data,
      createdAt: DateTime.now(),
      endAt: configuration.dataCacheOptions.invalidationMethod.endAt,
    );
  }

  @override
  DataCacheEntity<T> update<T extends Object>(T data, DataCacheEntity<T> cache) {
    return DataCacheEntity<T>(
      id: cache.id,
      data: data,
      usageCount: cache.usageCount,
      createdAt: cache.createdAt,
      endAt: configuration.dataCacheOptions.invalidationMethod.endAt,
      updatedAt: DateTime.now(),
    );
  }
}
