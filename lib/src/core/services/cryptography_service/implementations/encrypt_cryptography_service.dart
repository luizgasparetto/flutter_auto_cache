import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import '../../../configuration/cache_configuration.dart';
import '../i_cryptography_service.dart';

import 'factories/encrypter_factory.dart';

final class EncryptCryptographyService implements ICryptographyService {
  final CacheConfiguration configuration;

  const EncryptCryptographyService(this.configuration);

  @override
  String encrypt(String value) {
    final cryptographyOptions = configuration.cryptographyOptions;

    if (cryptographyOptions == null) return value;

    final encrypter = EncrypterFactory.instance.createEncrypter(cryptographyOptions.secretKey);
    final iv = EncrypterFactory.instance.createIv(cryptographyOptions.secretKey);

    final encrypted = encrypter.encrypt(value, iv: iv);
    return base64Encode(encrypted.bytes);
  }

  @override
  String decrypt(String value) {
    final cryptographyOptions = configuration.cryptographyOptions;

    if (cryptographyOptions == null) return value;

    final encrypter = EncrypterFactory.instance.createEncrypter(cryptographyOptions.secretKey);
    final iv = EncrypterFactory.instance.createIv(cryptographyOptions.secretKey);

    final bytes = base64Decode(value);
    return encrypter.decrypt(Encrypted(bytes), iv: iv);
  }
}
