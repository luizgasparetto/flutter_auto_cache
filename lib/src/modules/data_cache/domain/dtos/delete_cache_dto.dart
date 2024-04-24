import '../enums/storage_type.dart';

class DeleteCacheDTO {
  final String key;
  final StorageType storageType;

  const DeleteCacheDTO._({
    required this.key,
    required this.storageType,
  });

  factory DeleteCacheDTO.prefs({required String key}) {
    return DeleteCacheDTO._(key: key, storageType: StorageType.prefs);
  }

  factory DeleteCacheDTO.sql({required String key}) {
    return DeleteCacheDTO._(key: key, storageType: StorageType.sql);
  }
}
