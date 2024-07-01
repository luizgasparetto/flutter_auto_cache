import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigMock extends Mock implements CacheConfiguration {}

void main() {
  final cacheConfig = CacheConfigMock();
  final sut = EncryptCryptographyService(cacheConfig);

  const options = CacheCryptographyOptions(secretKey: 'mySecretKey');

  tearDown(() {
    reset(cacheConfig);
  });

  group('CryptographyService.integration |', () {
    test('should be able to encrypt and decrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);

      final stopwatch = Stopwatch()..start();

      final encryptedData = sut.encrypt('value');
      final decryptedData = sut.decrypt(encryptedData);

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptedData, isA<String>());
      expect(decryptedData, equals('value'));
    });
  });
}
