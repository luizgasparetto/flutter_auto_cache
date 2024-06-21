import 'package:flutter/foundation.dart';

import '../dtos/write_cache_dto.dart';
import '../enums/invalidation_type.dart';

/// Immutable class representing a cache entity.
///
/// A `CacheEntity` encapsulates data along with metadata for caching purposes.
/// It contains a unique identifier `id`, the associated data `data`,
/// the type of invalidation `invalidationType`, creation timestamp `createdAt`,
/// expiration timestamp `endAt`, and an optional last update timestamp `updatedAt`.
///
/// This class provides several factory constructors for convenience in creating instances,
/// including `generate`, which automatically generates timestamps,
/// and `fromDto`, which constructs a `CacheEntity` from a data transfer object (DTO).
///
/// It also overrides the equality operator `==` and hashCode getter
/// to enable comparison and hashing based on the cache entity's unique identifier `id`.
@immutable
class CacheEntity<T extends Object> {
  /// Unique identifier for the cache entity.
  final String id;

  /// Data associated with the cache entity.
  final T data;

  /// Type of invalidation for the cache entity.
  final InvalidationType invalidationType;

  /// Timestamp indicating when the cache entity was created.
  final DateTime createdAt;

  /// Timestamp indicating when the cache entity will expire.
  final DateTime endAt;

  /// Timestamp indicating when the cache entity was last updated (nullable).
  final DateTime? updatedAt;

  const CacheEntity({
    required this.id,
    required this.data,
    required this.invalidationType,
    required this.createdAt,
    this.updatedAt,
    required this.endAt,
  });

  factory CacheEntity._generate({
    required String id,
    required T data,
    required InvalidationType invalidationType,
    required Duration expireMaxDuration,
    DateTime? updatedAt,
  }) {
    return CacheEntity<T>(
      id: id,
      data: data,
      invalidationType: invalidationType,
      createdAt: DateTime.now(),
      endAt: DateTime.now().add(expireMaxDuration),
      updatedAt: updatedAt,
    );
  }

  factory CacheEntity.save(WriteCacheDTO<T> dto) {
    return CacheEntity._generate(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      expireMaxDuration: dto.cacheConfig.ttlMaxDuration,
    );
  }

  factory CacheEntity.update(WriteCacheDTO<T> dto) {
    return CacheEntity._generate(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      expireMaxDuration: dto.cacheConfig.ttlMaxDuration,
      updatedAt: DateTime.now(),
    );
  }

  CacheEntity<T> copyWith({
    String? id,
    T? data,
    InvalidationType? invalidationType,
    DateTime? createdAt,
    DateTime? endAt,
    DateTime? updatedAt,
  }) {
    return CacheEntity<T>(
      id: id ?? this.id,
      data: data ?? this.data,
      invalidationType: invalidationType ?? this.invalidationType,
      createdAt: createdAt ?? this.createdAt,
      endAt: endAt ?? this.endAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
