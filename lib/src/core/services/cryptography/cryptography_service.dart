import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/cryptography/entities/decrypted_data.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/entities/encrypted_data.dart';
import 'package:cryptography/cryptography.dart';

import 'i_cryptography_service.dart';

class CryptographyService implements ICryptographyService {
  final String secret = 'mySecretKey';

  @override
  Future<DecryptedData> decrypt(EncryptedData encryptData) async {
    final algorithm = AesGcm.with256bits();
    final hashedSecret = await Blake2s().hash(utf8.encode(secret));
    final secretKey = await algorithm.newSecretKeyFromBytes(hashedSecret.bytes);

    final secretBox = await algorithm.decrypt(
      encryptData.data,
      secretKey: secretKey,
    );

    final decryptedJson = utf8.decode(secretBox);
    final jsonString = jsonDecode(decryptedJson);

    return DecryptedData(data: jsonString);
  }

  @override
  Future<EncryptedData> encrypt(DecryptedData decryptData) async {
    final algorithm = AesGcm.with256bits();
    final hashedSecret = await Blake2s().hash(utf8.encode(secret));
    final secretKey = await algorithm.newSecretKeyFromBytes(hashedSecret.bytes);
    final nonce = algorithm.newNonce();

    final jsonString = jsonEncode(decryptData.data);
    final dataInBytes = utf8.encode(jsonString);

    final secretBox = await algorithm.encrypt(
      dataInBytes,
      secretKey: secretKey,
      nonce: nonce,
    );

    return EncryptedData(data: secretBox);
  }
}
