import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/shared/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/shared/services/cache_size_service/value_objects/cache_size_options.dart';

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
