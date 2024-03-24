import '../../modules/cache/domain/constants/cache_constants.dart';
import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/value_objects/cache_size_options.dart';

class CacheConfig {
  final InvalidationType invalidationType;
  final CacheSizeOptions sizeOptions;

  CacheConfig({
    this.invalidationType = CacheConstants.defaultInvalidationType,
    CacheSizeOptions? sizeOptions,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig();

  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;
    final isDefaultCacheSizeOptions = sizeOptions == CacheSizeOptions.createDefault();

    return isDefaultInvalidation && isDefaultCacheSizeOptions;
  }
}
