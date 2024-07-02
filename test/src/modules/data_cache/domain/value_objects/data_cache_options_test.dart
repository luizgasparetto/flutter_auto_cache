import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sut = DataCacheOptions();

  group('DataCacheOptions.constructor |', () {
    test('should be able to validate default values of params', () {
      expect(sut.invalidationMethod, isA<TTLInvalidationMethod>());
      expect(sut.substitutionPolicy, equals(SubstitutionPolicies.fifo));
      expect(sut.replaceExpiredCache, isTrue);
    });
  });
}
