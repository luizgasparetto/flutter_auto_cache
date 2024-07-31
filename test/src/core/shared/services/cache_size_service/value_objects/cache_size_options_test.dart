import 'package:flutter_auto_cache/src/core/shared/services/cache_size_service/value_objects/cache_size_options.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheSizeOptions.asserts |', () {
    test('should be able to create a CacheSizeOptions when maxMb > 0', () {
      const options = CacheSizeOptions(maxMb: 50);

      expect(options.maxMb, equals(50));
    });

    test('should NOT be able to create a CacheSizeOptions when maxMb <= 0', () {
      expect(() => CacheSizeOptions(maxMb: -5), throwsA(isA<AssertionError>()));
      expect(() => CacheSizeOptions(maxMb: 0), throwsA(isA<AssertionError>()));
    });
  });

  group('CacheSizeOptions.totalKb |', () {
    test('should be able to calculate totalKb basead on maxKb and maxMb setted', () {
      const options = CacheSizeOptions(maxMb: 50);
      expect(options.totalKb, equals(51200.0));
    });
  });

  group('CacheSizeOptions.equals |', () {
    test('should be able to verify equality of instance based on maxKb and maxMb', () {
      const firstOptionsInstance = CacheSizeOptions(maxMb: 50);
      const secondOptionsInstance = CacheSizeOptions(maxMb: 50);

      expect(firstOptionsInstance, equals(secondOptionsInstance));
      expect(firstOptionsInstance.hashCode, equals(secondOptionsInstance.hashCode));
    });
  });
}
