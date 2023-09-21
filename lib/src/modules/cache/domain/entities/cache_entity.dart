import '../enums/storage_types.dart';

class CacheEntity<T> {
  final String id;
  final T data;
  final StorageTypes storageType;
  final DateTime createdAt;

  CacheEntity({
    required this.id,
    required this.data,
    required this.storageType,
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
