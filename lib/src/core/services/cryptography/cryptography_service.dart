import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/cryptography/dtos/decrypt_dto.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/dtos/encrypt_dto.dart';
import 'package:cryptography/cryptography.dart';

import 'i_cryptography_service.dart';

class CryptographyService implements ICryptographyService {
  @override
  Future<DecryptData> decrypt(EncryptData encryptData) async {
    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();

    // decryptData.data to Uint8List
    final dataInBytes = utf8.encode(encryptData.data);

    final secretBox = await algorithm.encrypt(
      dataInBytes,
      secretKey: secretKey,
      nonce: nonce,
    );
    print('Ciphertext: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac}');

    return Future.value(const DecryptData(data: ''));
  }

  @override
  Future<EncryptData> encrypt(DecryptData decryptData) async {
    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();

    // decryptData.data to Uint8List
    final dataInBytes = utf8.encode(decryptData.data);

    final secretBox = await algorithm.encrypt(
      dataInBytes,
      secretKey: secretKey,
      nonce: nonce,
    );
    print('Ciphertext: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac}');

    return Future.value(const EncryptData(data: ''));
  }
}
