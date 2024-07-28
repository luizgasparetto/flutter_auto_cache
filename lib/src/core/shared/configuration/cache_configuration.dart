import '../../../modules/data_cache/domain/value_objects/data_cache_options.dart';
import '../services/cache_size_service/value_objects/cache_size_options.dart';
import '../services/cryptography_service/value_objects/cache_cryptography_options.dart';

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

  /// Constructs a CacheConfiguration object.
  ///
  /// [sizeOptions] Options for cache size.
  /// [ttlMaxDuration] Maximum time-to-live duration for cache items.
  /// [cryptographyOptions] Options for cache cryptography.
  const CacheConfiguration({
    this.sizeOptions = const CacheSizeOptions(),
    this.cryptographyOptions,
    this.dataCacheOptions = const DataCacheOptions(),
  });

  /// Constructs a default CacheConfiguration object.
  ///
  /// This factory method provides a default configuration
  /// for caching settings.
  factory CacheConfiguration.defaultConfig() => const CacheConfiguration();

  CacheConfiguration _copyWith({
    DataCacheOptions? dataCacheOptions,
    CacheSizeOptions? sizeOptions,
    CacheCryptographyOptions? cryptographyOptions,
  }) {
    return CacheConfiguration(
      dataCacheOptions: dataCacheOptions ?? this.dataCacheOptions,
      sizeOptions: sizeOptions ?? this.sizeOptions,
      cryptographyOptions: cryptographyOptions ?? this.cryptographyOptions,
    );
  }
}

extension PrivateGettersCacheConfiguration on CacheConfiguration {
  bool get isDefaultConfig => this == const CacheConfiguration();
}

extension PrivateSettersCacheConfiguration on CacheConfiguration {
  CacheConfiguration setDataOptions(DataCacheOptions options) => _copyWith(dataCacheOptions: options);
}
