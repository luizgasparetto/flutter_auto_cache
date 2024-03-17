import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/enums/storage_type.dart';
import '../constants/cache_constants.dart';

class CacheConfig {
  final StorageType storageType;
  final InvalidationType invalidationType;

  const CacheConfig({
    required this.storageType,
    required this.invalidationType,
  });

  factory CacheConfig.defaultConfig() {
    return const CacheConfig(
      storageType: CacheConstants.defaultStorageType,
      invalidationType: CacheConstants.defaultInvalidationType,
    );
  }

  bool get isDefaultConfig {
    final isDefaultStorage = storageType == CacheConstants.defaultStorageType;
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;

    return isDefaultStorage && isDefaultInvalidation;
  }

  bool get isKvsSelected => this.storageType == StorageType.kvs;
}
