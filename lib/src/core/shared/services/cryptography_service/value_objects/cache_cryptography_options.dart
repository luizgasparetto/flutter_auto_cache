import 'package:flutter/foundation.dart';

import 'enums/cache_cryptography_methods.dart';

/// Defines options for cache cryptography, including a secret key and encryption method.
///
/// This class configures cache encryption and decryption by specifying the
/// cryptographic method and a secret key. It ensures that the secret key is
/// not empty, enhancing security.
@immutable
class CacheCryptographyOptions {
  /// The secret key used for cryptographic operations.
  ///
  /// This key must be a non-empty string and is used with the chosen cryptography
  /// method to secure cache data.
  final String secretKey;

  /// The cryptography method applied for encrypting and decrypting cache data.
  ///
  /// Determines the algorithm used for securing the cache. Options are defined
  /// in [CacheCryptographyMethods].
  final CacheCryptographyMethods cryptographyMethod;

  /// Creates a [CacheCryptographyOptions] instance with the provided [secretKey]
  /// and [cryptographyMethod].
  ///
  /// The [secretKey] must be non-empty. An assertion will be triggered if an
  /// empty string is provided.
  ///
  /// [secretKey] The non-empty secret key for cryptographic operations.
  /// [cryptographyMethod] The method to use for cache encryption and decryption.
  CacheCryptographyOptions({
    required this.secretKey,
    required this.cryptographyMethod,
  }) : assert(secretKey.isNotEmpty, _assertErrorMessage);

  static const String _assertErrorMessage = 'Secret key cannot be empty. Please provide a non-empty string as the secret key.';

  @override
  bool operator ==(covariant CacheCryptographyOptions other) {
    if (identical(this, other)) return true;

    return other.secretKey == secretKey;
  }

  @override
  int get hashCode => secretKey.hashCode;
}
