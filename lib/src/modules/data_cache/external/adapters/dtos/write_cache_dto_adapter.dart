import '../../../domain/dtos/write_cache_dto.dart';
import '../../../domain/entities/cache_entity.dart';

class WriteCacheDTOAdapter {
  static CacheEntity<T> toSave<T extends Object>(WriteCacheDTO<T> dto) {
    return CacheEntity<T>(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      createdAt: DateTime.now(),
      endAt: DateTime.now().add(dto.cacheConfig.ttlMaxDuration),
    );
  }

  static CacheEntity<T> toUpdate<T extends Object>(WriteCacheDTO<T> dto) {
    return CacheEntity<T>(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      createdAt: DateTime.now(),
      endAt: DateTime.now().add(dto.cacheConfig.ttlMaxDuration),
      updatedAt: DateTime.now(),
    );
  }
}
