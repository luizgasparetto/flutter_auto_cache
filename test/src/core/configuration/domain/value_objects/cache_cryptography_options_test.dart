import 'package:flutter_auto_cache/src/core/services/cryptography_service/value_objects/cache_cryptography_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheCryptographyOptions.equals |', () {
    test('should be able to verify equals based on secretKey', () async {
      const firstCryptographyOptions = CacheCryptographyOptions(secretKey: 'secre_key');
      const secondCryptographyOptions = CacheCryptographyOptions(secretKey: 'secre_key');

      expect(firstCryptographyOptions, equals(secondCryptographyOptions));
      expect(firstCryptographyOptions.hashCode, equals(secondCryptographyOptions.hashCode));
    });
  });
}
