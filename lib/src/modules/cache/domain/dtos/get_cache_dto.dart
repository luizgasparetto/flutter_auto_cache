import '../enums/storage_type.dart';

class GetCacheDTO {
  final String key;
  final StorageType storageType;

  const GetCacheDTO({
    required this.key,
    required this.storageType,
  });
}
