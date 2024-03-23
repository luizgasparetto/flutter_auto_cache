import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CryptographyService();

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encrypted = await sut.encrypt('decrypted');

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encrypted, isNotNull);
    });

    test('should be able to encrypt and decrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptedData = await sut.encrypt('decrypted');

      final decryptedData = await sut.decrypt(encryptedData);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptedData, isA<String>());
      expect(decryptedData, equals('decrypted'));
    });
  });
}
