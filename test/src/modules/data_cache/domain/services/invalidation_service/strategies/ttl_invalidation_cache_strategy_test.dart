import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation/invalidation_status.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/services/invalidation_service/invalidation_cache_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNonExpiredDataCacheEntity extends Fake implements DataCacheEntity<String> {
  @override
  DateTime get endAt => DateTime.now().add(const Duration(days: 1));
}

class FakeExpiredDataCacheEntity extends Fake implements DataCacheEntity<String> {
  @override
  DateTime get endAt => DateTime.now().subtract(const Duration(days: 1));
}

void main() {
  final sut = TTLInvalidationCacheStrategy();

  final nonExpiredDataCacheEntity = FakeNonExpiredDataCacheEntity();
  final expiredCachEntity = FakeExpiredDataCacheEntity();

  group('TTLInvalidationCacheStrategy.validate |', () {
    test('should be able to validate an not expired cache successfully', () {
      final response = sut.validate(nonExpiredDataCacheEntity);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), InvalidationStatus.valid);
    });

    test('should be able to validate an expired cache when endAt is before now', () {
      final response = sut.validate(expiredCachEntity);

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), InvalidationStatus.invalid);
    });
  });
}
