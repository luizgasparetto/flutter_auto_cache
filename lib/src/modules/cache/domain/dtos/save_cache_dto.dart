import '../../../../../auto_cache_manager_library.dart';
import '../enums/invalidation_type.dart';
import '../enums/storage_type.dart';

class SaveCacheDTO<T> {
  final String key;
  final T data;
  final InvalidationType invalidationType;
  final StorageType storageType;

  const SaveCacheDTO._({
    required this.key,
    required this.data,
    required this.invalidationType,
    required this.storageType,
  });

  factory SaveCacheDTO.withConfig({required String key, required T data}) {
    final config = AutoCacheManagerInitialazer.instance.config;

    return SaveCacheDTO._(
      key: key,
      data: data,
      invalidationType: config.invalidationType,
      storageType: config.storageType,
    );
  }
}
