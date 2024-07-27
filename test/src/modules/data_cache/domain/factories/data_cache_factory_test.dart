import 'package:flutter_auto_cache/src/core/shared/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/shared/extensions/types/date_time_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/factories/data_cache_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final config = CacheConfiguration.defaultConfig();
  final sut = DataCacheFactory(config);

  group('DataCacheFactory.save |', () {
    const dto = WriteCacheDTO(key: 'personal_key', data: 'cache_data');

    test("should be able to create a DataCacheEntity to save's purpose successfully", () {
      final response = sut.save<String>(dto);

      expect(response.id, equals('personal_key'));
      expect(response.data, equals('cache_data'));
      expect(response.usageCount, equals(0));
      expect(response.createdAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.endAt?.withoutMilliseconds(), equals(config.dataCacheOptions.invalidationMethod.endAt.withoutMilliseconds()));
      expect(response.updatedAt, isNull);
      expect(response.usedAt, isNull);
    });
  });

  group('DataCacheFactory.update |', () {
    final cache = DataCacheEntity.fakeConfig('old_data', key: 'cache_key');

    test("should be able to create a DataCacheEntity to update's purpose successfully", () {
      final response = sut.update<String>('new_data', cache);

      expect(response.id, equals(cache.id));
      expect(response.data, equals('new_data'));
      expect(response.usageCount, equals(cache.usageCount));
      expect(response.createdAt, equals(cache.createdAt));
      expect(response.endAt?.withoutMilliseconds(), equals(config.dataCacheOptions.invalidationMethod.endAt.withoutMilliseconds()));
      expect(response.updatedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.usedAt, equals(cache.usedAt));
    });
  });

  group('DataCacheFactory.used |', () {
    final cache = DataCacheEntity.fakeConfig('data', key: 'cache_key');

    test("should be able to create a DataCacheEntity to used's purpose successfully", () {
      final response = sut.used<String>(cache);

      expect(response.id, equals(cache.id));
      expect(response.data, equals(cache.data));
      expect(response.usageCount, equals(cache.usageCount + 1));
      expect(response.createdAt, equals(cache.createdAt));
      expect(response.endAt, equals(cache.endAt));
      expect(response.updatedAt, equals(cache.updatedAt));
      expect(response.usedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
    });
  });
}
