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

  const DataCacheEntity({
    required this.id,
    required this.data,
    this.usageCount = 0,
    required this.createdAt,
    this.updatedAt,
    required this.endAt,
  });

  factory DataCacheEntity.fakeConfig(T data) {
    return DataCacheEntity<T>(
      id: String.fromCharCode(20),
      data: data,
      createdAt: DateTime.now(),
      endAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  DataCacheEntity<T> incrementCount() => _copyWith(usageCount: usageCount + 1);

  DataCacheEntity<T> _copyWith({int? usageCount}) {
    return DataCacheEntity<T>(
      id: id,
      data: data,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      endAt: endAt,
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
