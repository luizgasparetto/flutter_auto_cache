import 'package:flutter/foundation.dart';

import '../enums/invalidation_types.dart';

/// Immutable class representing a cache entity.
///
/// A `DataCacheEntity` encapsulates data along with metadata for caching purposes.
/// It contains a unique identifier `id`, the associated data `data`,
/// the type of invalidation `InvalidationTypes`, creation timestamp `createdAt`,
/// expiration timestamp `endAt`, and an optional last update timestamp `updatedAt`.
///
/// This class provides several factory constructors for convenience in creating instances,
/// including `generate`, which automatically generates timestamps,
/// and `fromDto`, which constructs a `DataCacheEntity` from a data transfer object (DTO).
///
/// It also overrides the equality operator `==` and hashCode getter
/// to enable comparison and hashing based on the cache entity's unique identifier `id`.
@immutable
class DataCacheEntity<T extends Object> {
  /// Unique identifier for the cache entity.
  final String id;

  /// Data associated with the cache entity.
  final T data;

  /// Type of invalidation for the cache entity.
  final InvalidationTypes invalidationType;

  /// Timestamp indicating when the cache entity was created.
  final DateTime createdAt;

  /// Timestamp indicating when the cache entity was last updated (nullable).
  final DateTime? updatedAt;

  /// Timestamp indicating when the cache entity will expire.
  final DateTime endAt;

  final DateTime? lastAccessAt;

  const DataCacheEntity({
    required this.id,
    required this.data,
    required this.invalidationType,
    required this.createdAt,
    this.updatedAt,
    required this.endAt,
    this.lastAccessAt,
  });

  factory DataCacheEntity.fakeConfig(T data) {
    return DataCacheEntity(
      id: 'any_id',
      data: data,
      invalidationType: InvalidationTypes.ttl,
      createdAt: DateTime.now(),
      endAt: DateTime.now(),
      lastAccessAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataCacheEntity<T> && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
