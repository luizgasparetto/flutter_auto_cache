import '../../modules/data_cache/domain/constants/cache_constants.dart';
import '../../modules/data_cache/domain/enums/invalidation_type.dart';

import '../../modules/data_cache/domain/value_objects/cache_cryptography_options.dart';
import '../../modules/data_cache/domain/value_objects/cache_size_options.dart';

class CacheConfig {
  final CacheSizeOptions sizeOptions;
  final Duration ttlMaxDuration;
  final CacheCryptographyOptions? cryptographyOptions;
  final bool useDeflateCompresser;

  CacheConfig({
    CacheSizeOptions? sizeOptions,
    this.ttlMaxDuration = CacheConstants.maxTtlDuration,
    this.cryptographyOptions,
    this.useDeflateCompresser = false,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  factory CacheConfig.defaultConfig() => CacheConfig();

  InvalidationType get invalidationType => InvalidationType.ttl;

  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;
    final isDefaultCacheSizeOptions = sizeOptions == CacheSizeOptions.createDefault();
    final isNotUsingDeflateCompresser = !useDeflateCompresser;

    return isDefaultInvalidation && isDefaultCacheSizeOptions && isNotUsingDeflateCompresser;
  }
}
