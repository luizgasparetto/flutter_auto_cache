import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/entities/decrypted_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CryptographyService();

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptedData = await sut.encrypt(const DecryptedData(data: 'decrypted'));

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encryptedData, isNotNull);
    });

    test('should be able to encrypt and decrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptedData = await sut.encrypt(const DecryptedData(data: 'decrypted'));

      final decryptedData = await sut.decrypt(encryptedData);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptedData.data, isA<String>());
      expect(decryptedData.data, equals('decrypted'));
    });
  });
}
