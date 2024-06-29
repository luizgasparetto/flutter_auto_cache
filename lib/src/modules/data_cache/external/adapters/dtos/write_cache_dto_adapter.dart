import '../../../domain/dtos/update_cache_dto.dart';
import '../../../domain/dtos/write_cache_dto.dart';
import '../../../domain/entities/data_cache_entity.dart';

final class WriteCacheDTOAdapter {
  static DataCacheEntity<T> toSave<T extends Object>(WriteCacheDTO<T> dto) {
    return DataCacheEntity<T>(
      id: dto.key,
      data: dto.data,
      usageCount: 0,
      invalidationType: dto.cacheConfig.invalidationType,
      createdAt: DateTime.now(),
      endAt: DateTime.now().add(dto.cacheConfig.ttlMaxDuration),
    );
  }

  static DataCacheEntity<T> toUpdate<T extends Object>(UpdateCacheDTO<T> dto) {
    return DataCacheEntity<T>(
      id: dto.previewCache.id,
      data: dto.previewCache.data,
      usageCount: dto.previewCache.usageCount,
      invalidationType: dto.config.invalidationType,
      createdAt: dto.previewCache.createdAt,
      endAt: DateTime.now().add(dto.config.ttlMaxDuration),
      updatedAt: DateTime.now(),
    );
  }
}
