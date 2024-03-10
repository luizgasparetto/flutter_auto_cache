import '../storage_dto.dart';

class StorageDTOAdapter {
  static StorageDTO<T> fromJson<T extends Object>(Map<String, dynamic> map) {
    return StorageDTO<T>(
      id: map['id'],
      data: map['data'],
      invalidationTypeCode: map['invalidation_type_code'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  static Map<String, dynamic> toJson<T extends Object>(StorageDTO<T> dto) {
    return {
      'id': dto.id,
      'data': dto.data,
      'invalidation_type_code': dto.invalidationTypeCode,
      'created_at': dto.createdAt.toIso8601String(),
    };
  }
}
