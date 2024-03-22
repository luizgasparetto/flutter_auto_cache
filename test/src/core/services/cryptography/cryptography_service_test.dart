import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/dtos/decrypt_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CryptographyService();

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptData = await sut.encrypt(const DecryptData(data: 'testObject'));

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encryptData, isNotNull);
    });

    test('should be able to encrypt and decrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptData = await sut.encrypt(const DecryptData(data: 'testObject'));

      final decryptData = await sut.decrypt(encryptData);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptData.data, isA<String>());
      expect(decryptData.data, equals('testObject'));
    });
  });
}
