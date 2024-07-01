import '../../../../core/core.dart';
import '../entities/data_cache_entity.dart';

class UpdateCacheDTO<T extends Object> {
  final DataCacheEntity<T> previewCache;
  final CacheConfiguration config;

  const UpdateCacheDTO({
    required this.previewCache,
    required this.config,
  });
}
