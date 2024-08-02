import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import '../../../../configuration/cache_configuration.dart';
import '../../value_objects/enums/cache_cryptography_methods.dart';

/// Factory class to create [Encrypter] instances with AES or other algorithms.
///
/// This class provides a static method to create an [Encrypter] configured with
/// an encryption algorithm based on the specified [CacheConfiguration].
class EncrypterFactory {
  /// Creates an [Encrypter] instance based on the given [CacheConfiguration].
  ///
  /// Uses the secret key to generate an AES key (or another key based on the
  /// cryptography method) and returns an [Encrypter] instance configured accordingly.
  ///
  /// Args:
  ///   configuration: An instance of [CacheConfiguration].
  ///
  /// Returns:
  ///   An [Encrypter] object configured with the selected encryption method.
  static Encrypter createEncrypter(CacheConfiguration configuration) {
    final key = _generateKey(configuration.cryptographyOptions?.secretKey ?? '');

    return switch (configuration.cryptographyOptions?.cryptographyMethod) {
      CacheCryptographyMethods.aes => Encrypter(AES(key, mode: AESMode.cbc)),
      CacheCryptographyMethods.fernet => Encrypter(Fernet(key)),
      CacheCryptographyMethods.salsa20 => Encrypter(Salsa20(key)),
      _ => Encrypter(AES(key, mode: AESMode.cbc))
    };
  }

  /// Generates a key from the given secret key by hashing it with SHA-256
  /// and encoding the result in base64.
  ///
  /// Args:
  ///   secretKey: A string used to generate the encryption key.
  ///
  /// Returns:
  ///   A [Key] object derived from the hashed secret key.
  static Key _generateKey(String secretKey) {
    final secretKeyBytes = utf8.encode(secretKey);
    final digest = sha256.convert(secretKeyBytes);

    final secretKeyHash = base64Url.encode(digest.bytes).substring(0, 32);
    return Key.fromUtf8(secretKeyHash);
  }
}
