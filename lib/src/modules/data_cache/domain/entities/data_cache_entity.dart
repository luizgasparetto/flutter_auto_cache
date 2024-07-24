import 'package:flutter/foundation.dart';

/// A class representing a cache entity with associated data and timestamps.
///
/// This class is designed to manage cached data along with metadata such as
/// creation time, last update time, and expiration time. It is immutable,
/// ensuring that once an instance is created, it cannot be modified.
@immutable
class DataCacheEntity<T extends Object> {
  final String id;
  final T data;
  final int usageCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? endAt;
  final DateTime? usedAt;

  const DataCacheEntity({
    required this.id,
    required this.data,
    required this.createdAt,
    required this.endAt,
    this.usageCount = 0,
    this.updatedAt,
    this.usedAt,
  });

  factory DataCacheEntity.fakeConfig(T data, {String? key, int? usageCount}) {
    return DataCacheEntity<T>(
      id: key ?? String.fromCharCode(20),
      data: data,
      usageCount: usageCount ?? 0,
      createdAt: DateTime.now(),
      endAt: DateTime.now(),
      updatedAt: DateTime.now(),
      usedAt: DateTime.now(),
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
