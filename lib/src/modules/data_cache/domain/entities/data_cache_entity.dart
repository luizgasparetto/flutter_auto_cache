import 'package:flutter/foundation.dart';

import '../../../../core/domain/entities/cache_entity.dart';
import '../../../../core/domain/enums/cache_type.dart';
import '../../../../core/domain/value_objects/cache_metadata.dart';

/// A class representing a cache entity with associated data and timestamps.
///
/// This class is designed to manage cached data along with metadata such as
/// creation time, last update time, and expiration time. It is immutable,
/// ensuring that once an instance is created, it cannot be modified.
@immutable
class DataCacheEntity<T extends Object> extends CacheEntity {
  final T data;

  const DataCacheEntity({
    required super.id,
    required this.data,
    required super.metadata,
    super.usageCount,
  }) : super(cacheType: CacheType.data);

  factory DataCacheEntity.fakeConfig(T data, {String? key, int? usageCount}) {
    return DataCacheEntity<T>(
      id: key ?? String.fromCharCode(20),
      data: data,
      usageCount: usageCount ?? 0,
      metadata: CacheMetadata.createDefault(),
    );
  }
}
