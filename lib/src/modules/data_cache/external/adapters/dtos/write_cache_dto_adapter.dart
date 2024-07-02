import '../../../domain/dtos/write_cache_dto.dart';
import '../../../domain/entities/data_cache_entity.dart';

final class WriteCacheDtoAdapter {
  static DataCacheEntity<T> toEntity<T extends Object>(WriteCacheDTO<T> dto) {
    return DataCacheEntity<T>(
      id: dto.key,
      data: dto.data,
      createdAt: DateTime.now(),
      endAt: dto.cacheConfig.dataCacheOptions.invalidationMethod.endAt,
    );
  }
}
