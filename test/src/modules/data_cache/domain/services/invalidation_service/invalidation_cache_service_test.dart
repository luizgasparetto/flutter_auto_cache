import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_types.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/data_cache_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigMock extends Mock implements CacheConfiguration {}

class FakeDataCacheEntity extends Fake implements DataCacheEntity<String> {
  @override
  DateTime get createdAt => DateTime.now().subtract(const Duration(days: 10));

  @override
  DateTime get endAt => DateTime.now().add(const Duration(days: 10));
}

void main() {
  final config = CacheConfigMock();
  final sut = InvalidationCacheService(config);

  tearDown(() {
    reset(config);
  });

  group('InvalidationCacheService.validate |', () {
    final cache = FakeDataCacheEntity();

    test('should be able to get a strategy and validate by passing the cache entity', () {
      when(() => config.dataCacheOptions).thenReturn(DataCacheOptions(invalidationType: InvalidationTypes.ttl));

      final response = sut.validate<String>(cache);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals(unit));
    });
  });
}