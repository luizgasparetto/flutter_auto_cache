import '../../modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'models/cache_cryptography_options.dart';
import 'models/cache_size_options.dart';

/// A configuration class for managing cache settings.
///
/// This class encapsulates various configurations related to caching,
/// including options for cache size, time-to-live duration for cache items,
/// cryptography options, and compressor usage.
class CacheConfiguration {
  final DataCacheOptions dataCacheOptions;

  /// Options for cache size.
  ///
  /// This determines the size boundaries for the cache.
  final CacheSizeOptions sizeOptions;

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
  CacheConfiguration({
    this.sizeOptions = const CacheSizeOptions(),
    this.cryptographyOptions,
    DataCacheOptions? dataCacheOptions,
    this.useDeflateCompresser = false,
  }) : this.dataCacheOptions = dataCacheOptions ?? DataCacheOptions();

  /// Constructs a default CacheConfig object.
  ///
  /// This factory method provides a default configuration
  /// for caching settings.
  factory CacheConfiguration.defaultConfig() => CacheConfiguration();
}
