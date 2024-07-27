import '../../../../core/shared/extensions/types/type_extensions.dart';

import '../../domain/entities/data_cache_entity.dart';

import 'exceptions/data_cache_adapter_exceptions.dart';

final class DataCacheAdapter {
  static DataCacheEntity<T> fromJson<T extends Object>(Map<String, dynamic> json) {
    try {
      return DataCacheEntity<T>(
        id: json['id'],
        data: json['data'],
        usageCount: json['usage_count'],
        createdAt: DateTime.parse(json['created_at']),
        endAt: DateTime.parse(json['end_at']),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      );
    } on TypeError catch (error, stackTrace) {
      final dataCacheType = json['data'].runtimeType;
      final isSameType = T.isSameType(dataCacheType);

      if (isSameType) throw DataCacheFromJsonException(exception: error, stackTrace: stackTrace);

      throw DataCacheTypeException<T>(type: dataCacheType, stackTrace: stackTrace);
    } catch (exception, stackTrace) {
      throw DataCacheFromJsonException(exception: exception, stackTrace: stackTrace);
    }
  }

  static DataCacheEntity<T> listFromJson<T extends Object, DataType extends Object>(Map<String, dynamic> json) {
    try {
      return DataCacheEntity<T>(
        id: json['id'],
        data: List.from(json['data']).whereType<DataType>().toList() as T,
        usageCount: json['usage_count'],
        createdAt: DateTime.parse(json['created_at']),
        endAt: DateTime.parse(json['end_at']),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      );
    } on TypeError catch (error, stackTrace) {
      final dataCacheType = json['data'].runtimeType;
      final isSameType = T.isSameType(dataCacheType);

      if (isSameType) throw DataCacheListFromJsonException(exception: error, stackTrace: stackTrace);

      throw DataCacheTypeException<T>(type: dataCacheType, stackTrace: stackTrace);
    } catch (exception, stackTrace) {
      throw DataCacheListFromJsonException(exception: exception, stackTrace: stackTrace);
    }
  }

  static Map<String, dynamic> toJson<T extends Object>(DataCacheEntity<T> cache) {
    return {
      'id': cache.id,
      'data': cache.data,
      'usage_count': cache.usageCount,
      'created_at': cache.createdAt.toIso8601String(),
      'end_at': cache.endAt?.toIso8601String(),
      'updated_at': cache.updatedAt?.toIso8601String(),
    };
  }
}
