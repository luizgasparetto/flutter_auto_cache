import '../../modules/data_cache/domain/constants/cache_constants.dart';
import '../../modules/data_cache/domain/enums/invalidation_type.dart';

import 'value_objects/cache_cryptography_options.dart';
import 'value_objects/cache_size_options.dart';

/// A configuration class for managing cache settings.
///
/// This class encapsulates various configurations related to caching,
/// including options for cache size, time-to-live duration for cache items,
/// cryptography options, and compressor usage.
class CacheConfig {
  /// Options for cache size.
  ///
  /// This determines the size boundaries for the cache.
  final CacheSizeOptions sizeOptions;

  /// Maximum time-to-live duration for cache items.
  ///
  /// This specifies the maximum duration for which a cache item remains valid.
  final Duration ttlMaxDuration;

  /// Options for cache cryptography.
  ///
  /// This provides flexibility for applying cryptographic operations
  /// to cache data, ensuring its security.
  final CacheCryptographyOptions? cryptographyOptions;

  /// Flag indicating whether to use Deflate compressor.
  ///
  /// This flag determines whether to utilize the Deflate compression
  /// algorithm for compressing cache data, potentially saving storage space.
  final bool useDeflateCompresser;

  /// Constructs a CacheConfig object.
  ///
  /// [sizeOptions] Options for cache size.
  /// [ttlMaxDuration] Maximum time-to-live duration for cache items.
  /// [cryptographyOptions] Options for cache cryptography.
  /// [useDeflateCompresser] Flag indicating whether to use Deflate compressor.
  CacheConfig({
    CacheSizeOptions? sizeOptions,
    this.ttlMaxDuration = CacheConstants.maxTtlDuration,
    this.cryptographyOptions,
    this.useDeflateCompresser = false,
  }) : sizeOptions = sizeOptions ?? CacheSizeOptions.createDefault();

  /// Constructs a default CacheConfig object.
  ///
  /// This factory method provides a default configuration
  /// for caching settings.
  factory CacheConfig.defaultConfig() => CacheConfig();

  /// Gets the invalidation type.
  ///
  /// This method retrieves the type of invalidation strategy
  /// used by the cache.
  InvalidationType get invalidationType => InvalidationType.ttl;

  /// Checks if this is the default configuration.
  ///
  /// This method verifies whether the current configuration
  /// matches the default settings for the cache.
  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheConstants.defaultInvalidationType;
    final isDefaultCacheSizeOptions = sizeOptions == CacheSizeOptions.createDefault();
    final isNotUsingDeflateCompresser = !useDeflateCompresser;

    return isDefaultInvalidation && isDefaultCacheSizeOptions && isNotUsingDeflateCompresser;
  }
}
