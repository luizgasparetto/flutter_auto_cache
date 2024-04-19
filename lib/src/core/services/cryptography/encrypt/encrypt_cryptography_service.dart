import 'dart:convert';

import 'package:auto_cache_manager/src/core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import '../i_cryptography_service.dart';

class EncryptCryptographyService implements ICryptographyService {
  final CacheConfig cacheConfig;

  const EncryptCryptographyService(this.cacheConfig);

  @override
  Future<String> decrypt(String value) async {
    final cryptographyOptions = cacheConfig.cryptographyOptions;

    if (cryptographyOptions != null) {
      final secretKeyHash = _generateSecretHash(cryptographyOptions.secretKey);

      final key = Key.fromUtf8(secretKeyHash);
      final iv = IV.fromBase64(base64Encode(utf8.encode(cryptographyOptions.secretKey)));

      final encrypter = Encrypter(AES(key));

      final bytes = base64Decode(value);
      final decrypted = encrypter.decrypt(Encrypted(bytes), iv: iv);

      return decrypted;
    }

    return value;
  }

  @override
  Future<String> encrypt(String value) async {
    final cryptographyOptions = cacheConfig.cryptographyOptions;

    if (cryptographyOptions != null) {
      final secretKeyHash = _generateSecretHash(cryptographyOptions.secretKey);

      final key = Key.fromUtf8(secretKeyHash);
      final iv = IV.fromBase64(base64Encode(utf8.encode(cryptographyOptions.secretKey)));

      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(value, iv: iv);

      return base64Encode(encrypted.bytes);
    }

    return value;
  }

  String _generateSecretHash(String secretKey) {
    final secretKeyBytes = utf8.encode(secretKey);
    final digest = sha256.convert(secretKeyBytes);

    return base64Url.encode(digest.bytes).substring(0, 32);
  }
}
