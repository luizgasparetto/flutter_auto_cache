import 'package:auto_cache_manager/src/core/services/cryptography/entities/decrypted_data.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/entities/encrypted_data.dart';

abstract interface class ICryptographyService {
  Future<EncryptedData> encrypt(DecryptedData encryptData);
  Future<DecryptedData> decrypt(EncryptedData decryptData);
}
