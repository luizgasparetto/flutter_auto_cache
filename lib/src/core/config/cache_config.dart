import '../../modules/data_cache/domain/constants/cache_constants.dart';
import '../../modules/data_cache/domain/enums/invalidation_type.dart';

import '../../modules/data_cache/domain/value_objects/cache_size_options.dart';
import '../../modules/data_cache/domain/value_objects/invalidation_methods/implementations/ttl_invalidation_method.dart';
import '../../modules/data_cache/domain/value_objects/invalidation_methods/invalidation_method.dart';

class CacheConfig {
  final CacheSizeOptions sizeOptions;
  final InvalidationMethod invalidationMethod;
  final String? cryptographyKey;

  CacheConfig({
    required this.invalidationMethod,
    CacheSizeOptions? sizeOptions,
    this.cryptographyKey,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig(invalidationMethod: const TTLInvalidationMethod());

  InvalidationType get invalidationType => invalidationMethod.invalidationType;

  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;
    final isDefaultCacheSizeOptions = sizeOptions == CacheSizeOptions.createDefault();

    return isDefaultInvalidation && isDefaultCacheSizeOptions;
  }

  Duration get expireMaxDuration {
    if (invalidationType == InvalidationType.ttl) {
      final typedInvalidation = invalidationMethod as TTLInvalidationMethod;
      return typedInvalidation.duration;
    }

    return CacheConstants.maxTtlDuration;
  }
}
