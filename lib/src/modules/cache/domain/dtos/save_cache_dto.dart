import 'package:flutter/foundation.dart';

import '../enums/storage_type.dart';

@immutable
class SaveCacheDTO<T extends Object> {
  final String key;
  final T data;
  final StorageType storageType;

  const SaveCacheDTO({
    required this.key,
    required this.data,
    required this.storageType,
  });

  @override
  bool operator ==(covariant SaveCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.key == key && other.data == data && other.storageType == storageType;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ storageType.hashCode;
  }
}
