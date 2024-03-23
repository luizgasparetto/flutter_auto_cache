import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'i_cryptography_service.dart';

class CryptographyService implements ICryptographyService {
  final String secretKey = 'mySecretKey';

  @override
  Future<String> decrypt(String value) async {
    final secretKeyHash = md5.convert(utf8.encode(secretKey)).toString();

    final key = Key.fromUtf8(secretKeyHash);
    final iv = IV.fromBase64(base64Encode(utf8.encode(secretKey)));

    final encrypter = Encrypter(AES(key));

    final bytes = base64Decode(value);
    final decrypted = encrypter.decrypt(Encrypted(bytes), iv: iv);

    return decrypted;
  }

  @override
  @override
  Future<String> encrypt(String value) async {
    final secretKeyHash = md5.convert(utf8.encode(secretKey)).toString();

    final key = Key.fromUtf8(secretKeyHash);
    final iv = IV.fromBase64(base64Encode(utf8.encode(secretKey)));

    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return base64Encode(encrypted.bytes);
  }
}
