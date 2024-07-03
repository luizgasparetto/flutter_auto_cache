import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/extensions/types/date_time_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/update_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/dtos/update_cache_dto_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cache = DataCacheEntity<String>(id: 'key', data: 'data', createdAt: DateTime.now(), endAt: DateTime.now());
  const config = CacheConfiguration();

  final dto = UpdateCacheDTO(value: 'new_value', previewCache: cache, config: const CacheConfiguration());
  final options = config.dataCacheOptions;

  group('UpdateCacheDtoAdapter.toEntity |', () {
    test('should be able to parse UpdateCacheDTO into a DataCacheEntity succesfully', () {
      final response = UpdateCacheDtoAdapter.toEntity<String>(dto);

      expect(response.id, equals(cache.id));
      expect(response.data, equals('new_value'));
      expect(response.createdAt, equals(cache.createdAt));
      expect(response.endAt?.withoutMilliseconds(), equals(options.invalidationMethod.endAt.withoutMilliseconds()));
      expect(response.updatedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
    });
  });
}
