import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/dtos/decrypt_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CryptographyService();
  final testObject = TestObject('text', 1);

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      final encryptData = await sut.encrypt(DecryptData(data: testObject));

      print(encryptData.data.cipherText);
      print(encryptData.data.mac);
      print(encryptData.data.nonce);

      expect(encryptData, isNotNull);
    });

    test('should be able to encrypt and decrypt data successfully', () async {
      final encryptData = await sut.encrypt(DecryptData(data: testObject));

      print(encryptData.data.cipherText);
      print(encryptData.data.mac);
      print(encryptData.data.nonce);

      final decryptData = await sut.decrypt(encryptData);

      expect(encryptData, isNotNull);
    });
  });
}

class TestObject {
  final String text;
  final double number;

  TestObject(this.text, this.number);
}
