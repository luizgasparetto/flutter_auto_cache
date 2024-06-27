import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/failures/invalidation_methods_failures.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/strategies/ttl_invalidation_cache_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNonExpiredCacheEntity extends Fake implements CacheEntity<String> {
  @override
  DateTime get endAt => DateTime.now().add(const Duration(days: 1));
}

class FakeExpiredCacheEntity extends Fake implements CacheEntity<String> {
  @override
  DateTime get endAt => DateTime.now().subtract(const Duration(days: 1));
}

void main() {
  final sut = TTLInvalidationCacheStrategy();

  final nonExpiredCacheEntity = FakeNonExpiredCacheEntity();
  final expiredCachEntity = FakeExpiredCacheEntity();

  group('TTLInvalidationCacheStrategy.validate |', () {
    test('should be able to validate an not expired cache successfully', () {
      final response = sut.validate(nonExpiredCacheEntity);

      expect(response.isSuccess, isTrue);
      expect(response.success, isA<Unit>());
    });

    test('should be able to validate an expired cache when endAt is before now', () {
      final response = sut.validate(expiredCachEntity);

      expect(response.isError, isTrue);
      expect(response.error, isA<ExpiredTTLFailure>());
    });
  });
}
