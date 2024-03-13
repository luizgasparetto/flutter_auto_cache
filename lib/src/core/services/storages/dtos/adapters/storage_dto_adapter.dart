import '../../exceptions/adapters_exceptions.dart';
import '../storage_dto.dart';

class StorageDTOAdapter {
  static StorageDTO<T> fromJson<T extends Object>(Map<String, dynamic> map) {
    try {
      return StorageDTO<T>(
        id: map['id'],
        data: map['data'],
        invalidationTypeCode: map['invalidation_type_code'],
        createdAt: DateTime.parse(map['created_at']),
      );
    } catch (e, st) {
      throw StorageAdapterException(
        code: 'storage_dto_from_json',
        message: 'Failed to parse Map<String, dynamic> into a StorageDTO',
        stackTrace: st,
      );
    }
  }

  static Map<String, dynamic> toJson(StorageDTO dto) {
    return {
      'id': dto.id,
      'data': dto.data,
      'invalidation_type_code': dto.invalidationTypeCode,
      'created_at': dto.createdAt.toIso8601String(),
    };
  }
}
