import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import '../../../config/cache_config.dart';
import '../i_cryptography_service.dart';

import 'factories/encrypter_factory.dart';

class EncryptCryptographyService implements ICryptographyService {
  final CacheConfig cacheConfig;

  const EncryptCryptographyService(this.cacheConfig);

  @override
  String encrypt(String value) {
    final cryptographyOptions = cacheConfig.cryptographyOptions;

    if (cryptographyOptions == null) return value;

    final encrypter = EncrypterFactory.I.createEncrypter(cryptographyOptions.secretKey);
    final iv = EncrypterFactory.I.createIv(cryptographyOptions.secretKey);

    final encrypted = encrypter.encrypt(value, iv: iv);
    return base64Encode(encrypted.bytes);
  }

  @override
  String decrypt(String value) {
    final cryptographyOptions = cacheConfig.cryptographyOptions;

    if (cryptographyOptions == null) return value;

    final encrypter = EncrypterFactory.I.createEncrypter(cryptographyOptions.secretKey);
    final iv = EncrypterFactory.I.createIv(cryptographyOptions.secretKey);

    final bytes = base64Decode(value);
    return encrypter.decrypt(Encrypted(bytes), iv: iv);
  }
}
