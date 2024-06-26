import '../../../../core/core.dart';
import '../entities/cache_entity.dart';

class UpdateCacheDTO<T extends Object> {
  final CacheEntity<T> previewCache;
  final CacheConfig config;

  const UpdateCacheDTO({
    required this.previewCache,
    required this.config,
  });
}
