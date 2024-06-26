import 'package:auto_cache_manager/src/core/configuration/constants/cache_size_constants.dart';
import 'package:auto_cache_manager/src/core/configuration/domain/value_objects/cache_size_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheSizeOptions.constants |', () {
    test('should be able to validate constants of cache size', () {
      expect(CacheSizeConstants.defaultMaxKb, equals(0));
      expect(CacheSizeConstants.defaultMaxMb, equals(40));
      expect(CacheSizeConstants.bytesPerKb, equals(1024));
      expect(CacheSizeConstants.bytesPerMb, equals(1024 * 1024));
    });
  });

  group('CacheSizeOptions.asserts |', () {
    test('should be able to create a CacheSizeOptions when maxMb > 0', () {
      const options = CacheSizeOptions(maxMb: 50);

      expect(options.maxMb, equals(50));
      expect(options.maxKb, equals(0));
    });

    test('should be able to create a CacheSizeOptions when maxKb >= 0', () {
      const options = CacheSizeOptions(maxKb: 500);

      expect(options.maxMb, equals(40));
      expect(options.maxKb, equals(500));
    });

    test('should NOT be able to create a CacheSizeOptions when maxMb <= 0', () {
      expect(() => CacheSizeOptions(maxMb: -5), throwsA(isA<AssertionError>()));
      expect(() => CacheSizeOptions(maxMb: 0), throwsA(isA<AssertionError>()));
    });

    test('should NOT be able to create a CacheSizeOptions when maxKb < 0', () {
      expect(() => CacheSizeOptions(maxKb: -5), throwsA(isA<AssertionError>()));
    });
  });

  group('CacheSizeOptions.totalMb |', () {
    test('should be able to calculate totalMb basead on maxKb and maxMb setted', () {
      const options = CacheSizeOptions(maxMb: 50, maxKb: 500);
      expect(options.totalMb, equals(50.5));
    });
  });

  group('CacheSizeOptions.equals |', () {
    test('should be able to verify equality of instance based on maxKb and maxMb', () {
      const firstOptionsInstance = CacheSizeOptions(maxMb: 50, maxKb: 500);
      const secondOptionsInstance = CacheSizeOptions(maxMb: 50, maxKb: 500);

      expect(firstOptionsInstance, equals(secondOptionsInstance));
      expect(firstOptionsInstance.hashCode, equals(secondOptionsInstance.hashCode));
    });
  });
}
