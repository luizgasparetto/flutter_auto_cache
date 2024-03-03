import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/enums/storage_type.dart';
import '../constants/cache_constants.dart';

class BaseConfig {
  final StorageType storageType;
  final InvalidationType invalidationType;

  const BaseConfig({
    required this.storageType,
    required this.invalidationType,
  });

  factory BaseConfig.defaultConfig() {
    return const BaseConfig(
      storageType: CacheConstants.defaultStorageType,
      invalidationType: CacheConstants.defaultInvalidationType,
    );
  }

  bool get isKvsSelected => this.storageType == StorageType.kvs;
}
