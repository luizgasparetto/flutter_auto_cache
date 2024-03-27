import '../enums/storage_type.dart';

class ClearCacheDTO {
  final StorageType storageType;

  const ClearCacheDTO({
    required this.storageType,
  });
}
