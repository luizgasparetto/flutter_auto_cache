import '../enums/storage_type.dart';

class DeleteCacheDTO {
  final String key;
  final StorageType storageType;

  const DeleteCacheDTO({
    required this.key,
    required this.storageType,
  });
}
