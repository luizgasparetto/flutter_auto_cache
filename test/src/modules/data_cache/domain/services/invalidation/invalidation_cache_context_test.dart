import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/services/invalidation/invalidation_cache_context.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CacheConfigMock extends Mock implements CacheConfig {}

class FakeCacheEntity extends Fake implements CacheEntity<String> {
  @override
  DateTime get createdAt => DateTime.now().subtract(const Duration(days: 10));

  @override
  DateTime get endAt => DateTime.now().add(const Duration(days: 10));
}

void main() {
  final config = CacheConfigMock();
  final sut = InvalidationCacheContext(config);

  tearDown(() {
    reset(config);
  });

  group('InvalidationCacheContext.execute |', () {
    final cache = FakeCacheEntity();

    test(
        'should be able to get a strategy and validate by passing the cache entity',
        () {
      when(() => config.invalidationType).thenReturn(InvalidationType.ttl);

      final response = sut.execute<String>(cache);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), equals(unit));
    });
  });
}
