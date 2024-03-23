import '../../modules/cache/domain/constants/cache_constants.dart';
import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/enums/storage_type.dart';
import '../../modules/cache/domain/value_objects/cache_size_options.dart';

class CacheConfig {
  final StorageType storageType;
  final InvalidationType invalidationType;
  final CacheSizeOptions sizeOptions;

  CacheConfig({
    this.storageType = CacheConstants.defaultStorageType,
    this.invalidationType = CacheConstants.defaultInvalidationType,
    CacheSizeOptions? sizeOptions,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig();

  bool get isDefaultConfig {
    final isDefaultStorage = storageType == CacheConstants.defaultStorageType;
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;

    return isDefaultStorage && isDefaultInvalidation;
  }

  bool get isPrefsSelected => this.storageType == StorageType.prefs;
}
