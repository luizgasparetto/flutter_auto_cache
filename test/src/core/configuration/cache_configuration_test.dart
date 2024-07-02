import 'package:flutter_auto_cache/flutter_auto_cache.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CacheConfiguration.defaultConfig();

  group('CacheConfig.defaultConfig |', () {
    test('should be able to validate attributes of default config', () {
      expect(sut.isDefaultConfig, isTrue);
      expect(sut.dataCacheOptions.invalidationMethod, isA<TTLInvalidationMethod>());
      expect(sut.sizeOptions, equals(const CacheSizeOptions()));
    });
  });
}
