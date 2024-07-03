import '../../domain/entities/data_cache_entity.dart';

final class DataCacheAdapter {
  static DataCacheEntity<T> fromJson<T extends Object>(Map<String, dynamic> json) {
    return DataCacheEntity<T>(
      id: json['id'],
      data: json['data'],
      createdAt: DateTime.parse(json['created_at']),
      endAt: DateTime.parse(json['end_at']),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }

  static DataCacheEntity<T> listFromJson<T extends Object, DataType extends Object>(Map<String, dynamic> json) {
    return DataCacheEntity<T>(
      id: json['id'],
      data: List.from(json['data']).whereType<DataType>().toList() as T,
      createdAt: DateTime.parse(json['created_at']),
      endAt: DateTime.parse(json['end_at']),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }

  static Map<String, dynamic> toJson<T extends Object>(DataCacheEntity<T> cache) {
    return {
      'id': cache.id,
      'data': cache.data,
      'created_at': cache.createdAt.toIso8601String(),
      'end_at': cache.endAt?.toIso8601String(),
      'updated_at': cache.updatedAt?.toIso8601String(),
    };
  }
}
