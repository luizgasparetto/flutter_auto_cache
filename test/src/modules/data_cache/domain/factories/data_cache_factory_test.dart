import 'package:flutter_auto_cache/src/core/shared/configuration/cache_configuration.dart';
import 'package:flutter_auto_cache/src/core/shared/extensions/types/date_time_extensions.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/factories/data_cache_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final config = CacheConfiguration.defaultConfig();
  final sut = DataCacheFactory(config);

  DateTime endAt() => config.dataCacheOptions.invalidationMethod.endAt;

  group('DataCacheFactory.save |', () {
    const dto = WriteCacheDTO(key: 'personal_key', data: 'cache_data');

    test("should be able to create a DataCacheEntity to save's purpose successfully", () {
      final response = sut.save<String>(dto);

      expect(response.id, equals('personal_key'));
      expect(response.data, equals('cache_data'));
      expect(response.usageCount, equals(0));
      expect(response.metadata.createdAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.metadata.endAt.withoutMilliseconds(), equals(endAt().withoutMilliseconds()));
      expect(response.metadata.updatedAt, isNull);
      expect(response.metadata.usedAt, isNull);
    });
  });

  group('DataCacheFactory.update |', () {
    final cache = DataCacheEntity.fakeConfig('old_data', key: 'cache_key');

    test("should be able to create a DataCacheEntity to update's purpose successfully", () {
      final response = sut.update<String>('new_data', cache);

      expect(response.id, equals(cache.id));
      expect(response.data, equals('new_data'));
      expect(response.usageCount, equals(cache.usageCount));
      expect(response.metadata.createdAt, equals(cache.metadata.createdAt));
      expect(response.metadata.endAt.withoutMilliseconds(), equals(endAt().withoutMilliseconds()));
      expect(response.metadata.updatedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.metadata.usedAt, equals(cache.metadata.usedAt));
    });
  });

  group('DataCacheFactory.used |', () {
    final cache = DataCacheEntity.fakeConfig('data', key: 'cache_key');

    test("should be able to create a DataCacheEntity to used's purpose successfully", () {
      final response = sut.used<String>(cache);

      expect(response.id, equals(cache.id));
      expect(response.data, equals(cache.data));
      expect(response.usageCount, equals(cache.usageCount + 1));
      expect(response.metadata.createdAt, equals(cache.metadata.createdAt));
      expect(response.metadata.endAt, equals(cache.metadata.endAt));
      expect(response.metadata.updatedAt, equals(cache.metadata.updatedAt));
      expect(response.metadata.usedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
    });
  });
}
