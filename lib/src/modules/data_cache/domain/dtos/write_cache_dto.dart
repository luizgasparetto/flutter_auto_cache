import 'package:auto_cache_manager/src/core/core.dart';
import 'package:flutter/foundation.dart';

@immutable
class WriteCacheDTO<T extends Object> {
  final String key;
  final T data;
  final CacheConfig cacheConfig;

  const WriteCacheDTO({
    required this.key,
    required this.data,
    required this.cacheConfig,
  });

  @override
  bool operator ==(covariant WriteCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.key == key && other.data == data && other.cacheConfig == cacheConfig;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ cacheConfig.hashCode;
  }
}
