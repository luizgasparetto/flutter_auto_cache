import 'package:auto_cache_manager/src/modules/cache/domain/value_objects/cache_cryptography_options.dart';

import '../../modules/cache/domain/constants/cache_constants.dart';
import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/enums/storage_type.dart';
import '../../modules/cache/domain/value_objects/cache_size_options.dart';

class CacheConfig {
  final StorageType storageType;
  final InvalidationType invalidationType;
  final CacheSizeOptions sizeOptions;
  final CacheCryptographyOptions? cryptographyOptions;

  CacheConfig({
    this.storageType = CacheConstants.defaultStorageType,
    this.invalidationType = CacheConstants.defaultInvalidationType,
    CacheSizeOptions? sizeOptions,
    this.cryptographyOptions,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig();

  bool get isDefaultConfig {
    final isDefaultStorage = storageType == CacheConstants.defaultStorageType;
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;

    return isDefaultStorage && isDefaultInvalidation;
  }

  bool get isPrefsSelected => this.storageType == StorageType.prefs;

  bool get cryptographyEnabled => cryptographyOptions != null;

  CacheConfig copyWith({
    StorageType? storageType,
    InvalidationType? invalidationType,
    CacheSizeOptions? sizeOptions,
    CacheCryptographyOptions? cryptographyOptions,
  }) {
    return CacheConfig(
      storageType: storageType ?? this.storageType,
      invalidationType: invalidationType ?? this.invalidationType,
      sizeOptions: sizeOptions ?? this.sizeOptions,
      cryptographyOptions: cryptographyOptions ?? this.cryptographyOptions,
    );
  }
}
