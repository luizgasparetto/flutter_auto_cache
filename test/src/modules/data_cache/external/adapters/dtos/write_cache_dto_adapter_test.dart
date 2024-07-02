import 'package:flutter_auto_cache/auto_cache.dart';
import 'package:flutter_auto_cache/src/core/extensions/types/date_time_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/dtos/write_cache_dto_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const config = CacheConfiguration();
  final options = config.dataCacheOptions;

  const dto = WriteCacheDTO(key: 'key', data: 'data', cacheConfig: config);

  group('WriteCacheDtoAdapter.toEntity |', () {
    test('should be able to parse a WriteCacheDTO into a DataCacheEntity successfully', () {
      final response = WriteCacheDtoAdapter.toEntity(dto);

      expect(response.id, equals(dto.key));
      expect(response.data, equals(dto.data));
      expect(response.createdAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.endAt?.withoutMilliseconds(), equals(options.invalidationMethod.endAt.withoutMilliseconds()));
      expect(response.updatedAt, isNull);
    });
  });
}
