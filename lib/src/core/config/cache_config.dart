import '../../modules/cache/domain/constants/cache_constants.dart';
import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/value_objects/cache_size_options.dart';
import '../../modules/cache/domain/value_objects/invalidation_methods/implementations/ttl_invalidation_method.dart';
import '../../modules/cache/domain/value_objects/invalidation_methods/invalidation_method.dart';

class CacheConfig {
  final CacheSizeOptions sizeOptions;
  final InvalidationMethod invalidationMethod;

  CacheConfig({
    required this.invalidationMethod,
    CacheSizeOptions? sizeOptions,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig(invalidationMethod: TTLInvalidationMethod());

  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;
    final isDefaultCacheSizeOptions = sizeOptions == CacheSizeOptions.createDefault();

    return isDefaultInvalidation && isDefaultCacheSizeOptions;
  }

  InvalidationType get invalidationType => invalidationMethod.invalidationType;
}
