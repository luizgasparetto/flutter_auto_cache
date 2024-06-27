import '../../../../core/core.dart';
import '../entities/cache_entity.dart';

class UpdateCacheDTO<T extends Object> {
  final CacheEntity<T> previewCache;
  final CacheConfiguration config;

  const UpdateCacheDTO({
    required this.previewCache,
    required this.config,
  });
}
