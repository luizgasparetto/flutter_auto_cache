import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/enums/invalidation_type_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvalidationTypeAdapter.fromKey |', () {
    test('should be able to get InvalidationType from key successfully', () {
      final refreshKey = InvalidationType.refresh.name;
      final ttlKey = InvalidationType.ttl.name;

      final refresh = InvalidationTypeAdapter.fromKey(refreshKey);
      final ttl = InvalidationTypeAdapter.fromKey(ttlKey);

      expect(refresh, equals(InvalidationType.refresh));
      expect(ttl, equals(InvalidationType.ttl));
    });

    test('should be able to get InvalidationType.refresh from invalid key successfully', () {
      const invalidKey = 'invalid';

      final refresh = InvalidationTypeAdapter.fromKey(invalidKey);

      expect(refresh, equals(InvalidationType.refresh));
    });
  });

  group('InvalidationTypeAdapter.toKey |', () {
    test('should be able to get key from InvalidationType successfully', () {
      final expectedRefreshKey = InvalidationType.refresh.name;
      final expectedTtlKey = InvalidationType.ttl.name;

      final refreshKey = InvalidationTypeAdapter.toKey(InvalidationType.refresh);
      final ttlKey = InvalidationTypeAdapter.toKey(InvalidationType.ttl);

      expect(refreshKey, equals(expectedRefreshKey));
      expect(ttlKey, equals(expectedTtlKey));
    });
  });
}
