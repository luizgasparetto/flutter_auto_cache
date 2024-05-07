import 'package:auto_cache_manager/src/core/core.dart';
import 'package:flutter/foundation.dart';

@immutable
class SaveCacheDTO<T extends Object> {
  final String key;
  final T data;
  final CacheConfig cacheConfig;

  const SaveCacheDTO({
    required this.key,
    required this.data,
    required this.cacheConfig,
  });

  @override
  bool operator ==(covariant SaveCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.key == key && other.data == data && other.cacheConfig == cacheConfig;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ cacheConfig.hashCode;
  }
}
