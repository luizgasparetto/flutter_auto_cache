import '../../../domain/dtos/update_cache_dto.dart';
import '../../../domain/entities/data_cache_entity.dart';

final class UpdateCacheDtoAdapter {
  static DataCacheEntity<T> toEntity<T extends Object>(UpdateCacheDTO<T> dto) {
    return DataCacheEntity<T>(
      id: dto.previewCache.id,
      data: dto.value,
      createdAt: dto.previewCache.createdAt,
      endAt: dto.config.dataCacheOptions.invalidationMethod.endAt,
      updatedAt: DateTime.now(),
    );
  }
}
