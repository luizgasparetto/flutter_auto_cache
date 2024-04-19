import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncrypterFactory {
  EncrypterFactory._();

  static final _instance = EncrypterFactory._();

  static EncrypterFactory get I => _instance;

  Encrypter createEncrypter(String secretKey) {
    final secretKeyHash = _generateSecretHash(secretKey);
    final key = Key.fromUtf8(secretKeyHash);

    return Encrypter(AES(key));
  }

  IV createIv(String secretKey) {
    final utf8Encode = utf8.encode(secretKey);
    final base64Encoded = base64Encode(utf8Encode);

    return IV.fromBase64(base64Encoded);
  }

  String _generateSecretHash(String secretKey) {
    final secretKeyBytes = utf8.encode(secretKey);
    final digest = sha256.convert(secretKeyBytes);

    return base64Url.encode(digest.bytes).substring(0, 32);
  }
}
