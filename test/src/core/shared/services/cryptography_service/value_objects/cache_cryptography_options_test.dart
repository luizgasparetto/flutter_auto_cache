import 'package:flutter_auto_cache/src/core/shared/services/cryptography_service/value_objects/cache_cryptography_options.dart';
import 'package:flutter_auto_cache/src/core/shared/services/cryptography_service/value_objects/enums/cache_cryptography_methods.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheCryptographyOptions.equals |', () {
    test('should be able to verify equals based on secretKey', () async {
      final firstCryptographyOptions = CacheCryptographyOptions(secretKey: 'secret_key', cryptographyMethod: CacheCryptographyMethods.aes);
      final secondCryptographyOptions = CacheCryptographyOptions(secretKey: 'secret_key', cryptographyMethod: CacheCryptographyMethods.aes);

      expect(firstCryptographyOptions, equals(secondCryptographyOptions));
      expect(firstCryptographyOptions.hashCode, equals(secondCryptographyOptions.hashCode));
    });
  });

  group('CacheCryptographyOptions.assert |', () {
    test('should be able to create a CacheCryptographyOptions when pass a non empty secretKey', () {
      final options = CacheCryptographyOptions(secretKey: 'secret_key', cryptographyMethod: CacheCryptographyMethods.aes);

      expect(options, isNotNull);
      expect(options.secretKey, equals('secret_key'));
    });

    test('should NOT be able to create a CacheCryptographyOptions when pass an empty secretKey', () {
      expect(
          () => CacheCryptographyOptions(secretKey: '', cryptographyMethod: CacheCryptographyMethods.aes), throwsA(isA<AssertionError>()));
    });
  });
}
