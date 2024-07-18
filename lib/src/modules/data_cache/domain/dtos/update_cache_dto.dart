import 'package:meta/meta.dart';

import '../../../../core/configuration/cache_configuration.dart';
import '../entities/data_cache_entity.dart';

@immutable
class UpdateCacheDTO<T extends Object> {
  final T value;
  final DataCacheEntity<T> previewCache;
  final CacheConfiguration config;

  const UpdateCacheDTO({
    required this.value,
    required this.previewCache,
    required this.config,
  });

  @override
  bool operator ==(covariant UpdateCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.value == value && other.previewCache == previewCache && other.config == config;
  }

  @override
  int get hashCode => value.hashCode ^ previewCache.hashCode ^ config.hashCode;
}
