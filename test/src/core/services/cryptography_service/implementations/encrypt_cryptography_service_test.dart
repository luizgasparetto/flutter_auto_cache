import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/exceptions/cryptography_exceptions.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigMock extends Mock implements CacheConfiguration {}

class EncrypterMock extends Mock implements Encrypter {}

void main() {
  final cacheConfig = CacheConfigMock();
  final encrypter = EncrypterMock();

  final sut = EncryptCryptographyService(cacheConfig, encrypter);

  final options = CacheCryptographyOptions(secretKey: 'mySecretKey');
  final encrypted = Encrypted(Uint8List(8));

  setUp(() {
    registerFallbackValue(IV(Uint8List(32)));
    registerFallbackValue(encrypted);
  });

  tearDown(() {
    reset(cacheConfig);
    reset(encrypter);
  });

  group('EncryptCryptographyService.encrypt |', () {
    test('should be able to encrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);
      when(() => encrypter.encrypt('value', iv: any(named: 'iv'))).thenReturn(Encrypted(Uint8List(8)));

      final response = sut.encrypt('value');

      expect(response.length, equals(32));
      verify(() => cacheConfig.cryptographyOptions).called(1);
      verify(() => encrypter.encrypt('value', iv: any(named: 'iv'))).called(1);
    });

    test('should be able to return NULL when cryptography options is not setted', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(null);

      final response = sut.encrypt('value');

      expect(response, equals('value'));
    });

    test('should NOT be able to return encrypted value when encrypter fails', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);
      when(() => encrypter.encrypt('value', iv: any(named: 'iv'))).thenThrow(Exception());

      expect(() => sut.encrypt('value'), throwsA(isA<EncryptException>()));
    });
  });

  group('EncryptCryptographyService.decrypt |', () {
    const encryptedValue = 'JiYmJiYmJiYmJiYmJiYmJgAAAAAAAAAA';

    test('should be able to decrypt data successfully', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);
      when(() => encrypter.decrypt(any(), iv: any(named: 'iv'))).thenReturn('decrypted_value');

      final response = sut.decrypt(encryptedValue);

      expect(response, equals('decrypted_value'));
      verify(() => cacheConfig.cryptographyOptions).called(1);
      verify(() => encrypter.decrypt(any(), iv: any(named: 'iv'))).called(1);
    });

    test('should be able to return base value when cryptography options is not setted', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(null);

      final response = sut.decrypt('base_value');

      expect(response, equals('base_value'));
      verify(() => cacheConfig.cryptographyOptions).called(1);
      verifyNever(() => encrypter.decrypt(any(), iv: any(named: 'iv')));
    });

    test('should NOT be able to decrypt data when encrypter fails', () {
      when(() => cacheConfig.cryptographyOptions).thenReturn(options);
      when(() => encrypter.decrypt(any(), iv: any(named: 'iv'))).thenThrow(Exception());

      expect(() => sut.decrypt(encryptedValue), throwsA(isA<DecryptException>()));
      verify(() => cacheConfig.cryptographyOptions).called(1);
      verify(() => encrypter.decrypt(any(), iv: any(named: 'iv'))).called(1);
    });
  });
}
