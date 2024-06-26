import 'package:flutter/foundation.dart';

@immutable
class InternalCacheInfo {
  final DateTime createdAt;
  final DateTime endAt;
  final DateTime? updatedAt;

  const InternalCacheInfo({
    required this.createdAt,
    required this.endAt,
    this.updatedAt,
  });

  @override
  bool operator ==(covariant InternalCacheInfo other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt && other.endAt == endAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => createdAt.hashCode ^ endAt.hashCode ^ updatedAt.hashCode;
}
