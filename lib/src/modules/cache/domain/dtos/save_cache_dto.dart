import 'package:flutter/foundation.dart';

import '../../../../../auto_cache_manager.dart';
import '../enums/invalidation_type.dart';
import '../enums/storage_type.dart';

@immutable
class SaveCacheDTO<T extends Object> {
  final String key;
  final T data;
  final InvalidationType invalidationType;
  final StorageType storageType;

  const SaveCacheDTO._({
    required this.key,
    required this.data,
    required this.invalidationType,
    required this.storageType,
  });

  factory SaveCacheDTO.withConfig({required String key, required T data}) {
    final config = AutoCacheManagerInitializer.I.config;

    return SaveCacheDTO._(
      key: key,
      data: data,
      invalidationType: config.invalidationType,
      storageType: config.storageType,
    );
  }

  @override
  bool operator ==(covariant SaveCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.data == data &&
        other.invalidationType == invalidationType &&
        other.storageType == storageType;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ invalidationType.hashCode ^ storageType.hashCode;
  }
}
