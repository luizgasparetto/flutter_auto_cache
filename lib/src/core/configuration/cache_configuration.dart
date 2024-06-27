// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'constants/cache_invalidation_constants.dart';
import '../../modules/data_cache/domain/enums/invalidation_types.dart';
import 'models/cache_cryptography_options.dart';
import 'models/cache_size_options.dart';

/// A configuration class for managing cache settings.
///
/// This class encapsulates various configurations related to caching,
/// including options for cache size, time-to-live duration for cache items,
/// cryptography options, and compressor usage.
class CacheConfiguration {
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

  final bool replaceExpiredCache;

  /// Constructs a CacheConfig object.
  ///
  /// [sizeOptions] Options for cache size.
  /// [ttlMaxDuration] Maximum time-to-live duration for cache items.
  /// [cryptographyOptions] Options for cache cryptography.
  /// [useDeflateCompresser] Flag indicating whether to use Deflate compressor.
  const CacheConfiguration({
    this.sizeOptions = const CacheSizeOptions(),
    this.ttlMaxDuration = CacheInvalidationConstants.maxTtlDuration,
    this.cryptographyOptions,
    this.useDeflateCompresser = false,
    this.replaceExpiredCache = true,
  });

  /// Constructs a default CacheConfig object.
  ///
  /// This factory method provides a default configuration
  /// for caching settings.
  factory CacheConfiguration.defaultConfig() => const CacheConfiguration();

  /// Gets the invalidation type.
  ///
  /// This method retrieves the type of invalidation strategy
  /// used by the cache.
  InvalidationTypes get invalidationType => InvalidationTypes.ttl;

  /// Checks if this is the default configuration.
  ///
  /// This method verifies whether the current configuration
  /// matches the default settings for the cache.
  bool get isDefaultConfig {
    final isDefaultInvalidation = invalidationType == CacheInvalidationConstants.defaultInvalidationTypes;
    final isDefaultCacheSizeOptions = sizeOptions == const CacheSizeOptions();
    final isNotUsingDeflateCompresser = !useDeflateCompresser;

    return isDefaultInvalidation && isDefaultCacheSizeOptions && isNotUsingDeflateCompresser;
  }
}
