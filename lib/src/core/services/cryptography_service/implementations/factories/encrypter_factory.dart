import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import '../../../../configuration/cache_configuration.dart';

/// A factory class for creating AES encrypters using a secret key.
///
/// This class provides a static method to create an [Encrypter] instance
/// configured with an AES algorithm and a key derived from a given secret key.
class EncrypterFactory {
  /// Creates an [Encrypter] instance using the given secret key.
  ///
  /// This method takes a secret key, hashes it using SHA-256, and then
  /// encodes the resulting hash to base64. The first 32 characters of the
  /// base64-encoded hash are used as the AES key for the [Encrypter].
  ///
  /// Args:
  ///   configuration: A instance of [CacheConfiguration].
  ///
  /// Returns:
  ///   An [Encrypter] object configured with an AES algorithm and the derived key.
  static Encrypter createEncrypter(CacheConfiguration configuration) {
    final secretKeyBytes = utf8.encode(configuration.cryptographyOptions?.secretKey ?? '');
    final digest = sha256.convert(secretKeyBytes);

    final secretKeyHash = base64Url.encode(digest.bytes).substring(0, 32);
    final key = Key.fromUtf8(secretKeyHash);

    return Encrypter(AES(key, mode: AESMode.cbc));
  }
}
