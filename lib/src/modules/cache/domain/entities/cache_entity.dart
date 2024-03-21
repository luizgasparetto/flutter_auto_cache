import 'package:flutter/foundation.dart';

import '../enums/invalidation_type.dart';

@immutable
class CacheEntity<T extends Object> {
  final String id;
  final T data;
  final InvalidationType invalidationType;
  final DateTime createdAt;

  CacheEntity({
    required this.id,
    required this.data,
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
