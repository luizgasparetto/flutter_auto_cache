import '../../domain/entities/cache_entity.dart';
import '../../domain/enums/storage_type.dart';

import 'enums/invalidation_type_adapter.dart';

class CacheAdapter {
  static CacheEntity<T> fromJson<T extends Object>(Map<String, dynamic> json, {required StorageType storageType}) {
    return CacheEntity<T>(
      id: json['id'],
      data: json['data'],
      storageType: storageType,
      createdAt: DateTime.parse(json['created_at']),
      invalidationType: InvalidationTypeAdapter.fromKey(json['invalidation_type']),
    );
  }

  static Map<String, dynamic> toJson<T extends Object>(CacheEntity<T> cache) {
    return {
      'id': cache.id,
      'data': cache.data,
      'created_at': cache.createdAt.toIso8601String(),
      'invalidation_type': InvalidationTypeAdapter.toKey(cache.invalidationType),
    };
  }
}
