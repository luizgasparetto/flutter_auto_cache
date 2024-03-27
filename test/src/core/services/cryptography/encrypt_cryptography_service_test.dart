import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/encrypt/encrypt_cryptography_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../constants/cache_test_constants.dart';

class CacheConfigMock extends Mock implements CacheConfig {}

void main() {
  final cacheConfig = CacheConfigMock();
  final sut = EncryptCryptographyService(cacheConfig);

  const decryptedStringValue = CacheTestConstants.decryptedStringValue;
  const encryptedStringValue = CacheTestConstants.encryptedStringValue;

  tearDown(() {
    reset(cacheConfig);
  });

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () async {
      when(() => cacheConfig.cryptographyKey).thenReturn('mySecretKey');

      final stopwatch = Stopwatch()..start();

      final encrypted = await sut.encrypt(decryptedStringValue);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encrypted, isNotNull);
    });
  });

  group('CryptographyService.decrypt |', () {
    test('should be able to decrypt data successfully', () async {
      when(() => cacheConfig.cryptographyKey).thenReturn('mySecretKey');

      final stopwatch = Stopwatch()..start();

      final decrypt = await sut.decrypt(encryptedStringValue);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decrypt, isNotNull);
    });
  });

  group('CryptographyService.integration |', () {
    test('should be able to encrypt and decrypt data successfully', () async {
      when(() => cacheConfig.cryptographyKey).thenReturn('mySecretKey');

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
