import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';

import '../../../configuration/cache_configuration.dart';
import '../exceptions/cryptography_exceptions.dart';
import '../i_cryptography_service.dart';

import 'factories/iv_factory.dart';

final class EncryptCryptographyService implements ICryptographyService {
  final Encrypter encrypter;
  final CacheConfiguration configuration;

  const EncryptCryptographyService(this.configuration, this.encrypter);

  @override
  String encrypt(String value) {
    try {
      if (configuration.cryptographyOptions == null) return value;

      final iv = IvFactory.createEncryptIv();

      final encrypted = encrypter.encrypt(value, iv: iv);
      final combined = _getCombinedBytes(iv, encrypted.bytes);

      return base64Encode(combined);
    } catch (exception, stackTrace) {
      throw EncryptException(
        message: 'An error occurred while encrypting data: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  String decrypt(String value) {
    try {
      if (configuration.cryptographyOptions == null) return value;

      final combined = base64Decode(value);

      final iv = IvFactory.createDecryptIv(combined);
      final encrypted = Encrypted(Uint8List.fromList(combined.sublist(16)));

      return encrypter.decrypt(encrypted, iv: iv);
    } catch (exception, stackTrace) {
      throw DecryptException(
        message: 'An error occurred while decrypting data: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  Uint8List _getCombinedBytes(IV iv, Uint8List encryptedBytes) {
    final uint8List = Uint8List(iv.bytes.length + encryptedBytes.length);
    final uint8ListWithIv = uint8List..setAll(0, iv.bytes);

    return uint8ListWithIv..setAll(iv.bytes.length, encryptedBytes);
  }
}
