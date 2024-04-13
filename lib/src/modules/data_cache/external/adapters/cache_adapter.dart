import '../../domain/entities/cache_entity.dart';
import 'enums/invalidation_type_adapter.dart';

class CacheAdapter {
  static CacheEntity<T> fromJson<T extends Object>(Map<String, dynamic> json) {
    return CacheEntity<T>(
      id: json['id'],
      data: json['data'],
      invalidationType: InvalidationTypeAdapter.fromKey(json['invalidation_type']),
      createdAt: DateTime.parse(json['created_at']),
      endAt: DateTime.parse(json['end_at']),
    );
  }

  static Map<String, dynamic> toJson<T extends Object>(CacheEntity<T> cache) {
    return {
      'id': cache.id,
      'data': cache.data,
      'invalidation_type': InvalidationTypeAdapter.toKey(cache.invalidationType),
      'created_at': cache.createdAt.toIso8601String(),
      'end_at': cache.endAt.toIso8601String(),
    };
  }
}
