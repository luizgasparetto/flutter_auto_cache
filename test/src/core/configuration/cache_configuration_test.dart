import 'package:flutter_auto_cache/src/core/configuration/domain/value_objects/cache_size_options.dart';
import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_type.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CacheConfiguration.defaultConfig();

  group('CacheConfig.defaultConfig |', () {
    test('should be able to validate attributes of default config', () {
      expect(sut.invalidationType, equals(InvalidationType.ttl));
      expect(sut.sizeOptions, equals(const CacheSizeOptions()));
    });
  });
}
