import 'package:flutter/foundation.dart';

import '../dtos/save_cache_dto.dart';
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

  /// Constructs a `CacheEntity` instance.
  ///
  /// The `id`, `data`, `invalidationType`, `createdAt`, and `endAt` parameters are required.
  const CacheEntity({
    required this.id,
    required this.data,
    required this.invalidationType,
    required this.createdAt,
    this.updatedAt,
    required this.endAt,
  });

  /// Constructs a `CacheEntity` instance with generated timestamps.
  ///
  /// The `id`, `data`, `invalidationType`, and `expireMaxDuration` parameters are required.
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

  /// Constructs a `CacheEntity` instance from a data transfer object (DTO).
  ///
  /// The `dto` parameter is required.
  factory CacheEntity.toSave(SaveCacheDTO<T> dto) {
    return CacheEntity._generate(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      expireMaxDuration: dto.cacheConfig.ttlMaxDuration,
    );
  }

  factory CacheEntity.toUpdate(SaveCacheDTO<T> dto) {
    return CacheEntity._generate(
      id: dto.key,
      data: dto.data,
      invalidationType: dto.cacheConfig.invalidationType,
      expireMaxDuration: dto.cacheConfig.ttlMaxDuration,
      updatedAt: DateTime.now(),
    );
  }

  /// Creates a copy of this cache entity with optional new values for its fields.
  ///
  /// This method provides a way to clone the current instance while possibly
  /// changing some of its properties. It's useful for modifying instances of
  /// immutable classes.
  ///
  /// - Parameters:
  ///   - `id`: An optional new unique identifier for the cache entity.
  ///   - `data`: An optional new data of type `T` for the cache entity.
  ///   - `invalidationType`: An optional new invalidation type for the cache entity.
  ///   - `createdAt`: An optional new creation date and time for the cache entity.
  ///   - `endAt`: An optional new expiration date and time for the cache entity.
  ///   - `updatedAt`: An optional new update date and time for the cache entity.
  ///
  /// - Returns: A new `CacheEntity<T>` instance with updated fields as provided.
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

  /// Equality comparison for `CacheEntity`.
  ///
  /// Two cache entities are considered equal if their unique identifiers `id` are equal.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheEntity<T> && other.id == id;
  }

  /// Hash code generation for `CacheEntity`.
  ///
  /// Returns the hash code based on the unique identifier `id` of the cache entity.
  @override
  int get hashCode => id.hashCode;
}
