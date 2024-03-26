import 'package:auto_cache_manager/src/modules/cache/domain/services/cryptography/cryptography_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../constants/cache_test_constants.dart';

void main() {
  final sut = CryptographyService();

  const decryptedStringValue = CacheTestConstants.decryptedStringValue;
  const encryptedStringValue = CacheTestConstants.encryptedStringValue;

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encrypted = await sut.encrypt(decryptedStringValue);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encrypted, isNotNull);
    });
  });

  group('CryptographyService.decrypt |', () {
    test('should be able to decrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final decrypt = await sut.decrypt(encryptedStringValue);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decrypt, isNotNull);
    });
  });

  group('CryptographyService integration |', () {
    test('should be able to encrypt and decrypt data successfully', () async {
      final stopwatch = Stopwatch()..start();

      final encryptedData = await sut.encrypt(decryptedStringValue);

      final decryptedData = await sut.decrypt(encryptedData);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptedData, isA<String>());
      expect(decryptedData, equals(decryptedStringValue));
    });
  });
}
