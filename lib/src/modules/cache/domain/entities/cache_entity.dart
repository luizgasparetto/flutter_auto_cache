import 'package:flutter/foundation.dart';

import '../enums/invalidation_type.dart';
import '../enums/storage_type.dart';

@immutable
class CacheEntity<T> {
  final String id;
  final T data;
  final StorageType storageType;
  final InvalidationType invalidationType;
  final DateTime createdAt;

  CacheEntity({
    required this.id,
    required this.data,
    required this.storageType,
    required this.invalidationType,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheEntity<T> && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
