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
    final cryptographyKey = cacheConfig.cryptographyKey;

    if (cryptographyKey != null) {
      final secretKeyHash = md5.convert(utf8.encode(cryptographyKey)).toString();

      final key = Key.fromUtf8(secretKeyHash);
      final iv = IV.fromBase64(base64Encode(utf8.encode(cryptographyKey)));

      final encrypter = Encrypter(AES(key));

      final bytes = base64Decode(value);
      final decrypted = encrypter.decrypt(Encrypted(bytes), iv: iv);

      return decrypted;
    }

    return value;
  }

  @override
  Future<String> encrypt(String value) async {
    final cryptographyKey = cacheConfig.cryptographyKey;

    if (cryptographyKey != null) {
      final secretKeyHash = md5.convert(utf8.encode(cryptographyKey)).toString();

      final key = Key.fromUtf8(secretKeyHash);
      final iv = IV.fromBase64(base64Encode(utf8.encode(cryptographyKey)));

      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(value, iv: iv);

      return base64Encode(encrypted.bytes);
    }

    return value;
  }
}
