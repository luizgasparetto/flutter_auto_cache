import 'package:auto_cache_manager/src/core/services/cryptography/dtos/decrypt_dto.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/dtos/encrypt_dto.dart';

abstract interface class ICryptographyService {
  Future<EncryptData> encrypt(DecryptData encryptData);
  Future<DecryptData> decrypt(EncryptData decryptData);
}
