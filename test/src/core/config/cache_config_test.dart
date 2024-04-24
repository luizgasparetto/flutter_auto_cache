import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/core/config/value_objects/cache_size_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = CacheConfig.defaultConfig();

  group('CacheConfig.defaultConfig |', () {
    test('should be able to validate attributes of default config', () {
      expect(sut.invalidationType, equals(InvalidationType.ttl));
      expect(sut.sizeOptions, equals(CacheSizeOptions.createDefault()));
    });
  });
}
