import 'dart:convert';

import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'package:flutter_auto_cache/src/core/configuration/models/cache_cryptography_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/constants/cache_test_constants.dart';

class CacheConfigMock extends Mock implements CacheConfiguration {}

void main() {
  final cacheConfig = CacheConfigMock();
  final sut = EncryptCryptographyService(cacheConfig);

  const options = CacheCryptographyOptions(secretKey: 'mySecretKey');

  const decryptedStringValue = CacheTestConstants.decryptedStringValue;
  const encryptedStringValue = CacheTestConstants.encryptedStringValue;

  tearDown(() {
    reset(cacheConfig);
  });

  group('CryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);

      final stopwatch = Stopwatch()..start();

      final map = {'key': 'personal-key', 'data': 'personal_data'};
      final jsonEncoded = jsonEncode(map);

      final encrypted = sut.encrypt(jsonEncoded);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(encrypted, isNotNull);
    });
  });

  group('CryptographyService.decrypt |', () {
    test('should be able to decrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);

      final stopwatch = Stopwatch()..start();

      final decrypt = sut.decrypt(encryptedStringValue);

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decrypt, isNotNull);
    });
  });

  group('CryptographyService.integration |', () {
    test('should be able to encrypt and decrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);

      final stopwatch = Stopwatch()..start();

      final encryptedData = sut.encrypt(decryptedStringValue);

      final decryptedData = sut.decrypt(encryptedData);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
      expect(decryptedData, isA<String>());
      expect(decryptedData, equals(decryptedStringValue));
    });
  });
}
