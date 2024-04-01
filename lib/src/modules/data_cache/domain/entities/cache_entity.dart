import 'package:flutter/foundation.dart';

import '../dtos/save_cache_dto.dart';
import '../enums/invalidation_type.dart';

@immutable
class CacheEntity<T extends Object> {
  final String id;
  final T data;
  final InvalidationType invalidationType;
  final DateTime createdAt;
  final DateTime endAt;

  const CacheEntity({
    required this.id,
    required this.data,
    required this.invalidationType,
    required this.createdAt,
    required this.endAt,
  });

  factory CacheEntity.generate({
    required String id,
    required T data,
    required InvalidationType invalidationType,
    required Duration expireMaxDuration,
  }) {
    return CacheEntity(
      id: id,
      data: data,
      invalidationType: invalidationType,
      createdAt: DateTime.now(),
      endAt: DateTime.now().add(expireMaxDuration),
    );
  }

  factory CacheEntity.fromDto(SaveCacheDTO<T> dto) {
    return CacheEntity.generate(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      expireMaxDuration: dto.cacheConfig.ttlMaxDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheEntity<T> && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
