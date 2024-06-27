import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_types.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/enums/invalidation_types_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvalidationTypesAdapter.fromKey |', () {
    test('should be able to get InvalidationTypes from key successfully', () {
      final refreshKey = InvalidationTypes.refresh.name;
      final ttlKey = InvalidationTypes.ttl.name;

      final refresh = InvalidationTypesAdapter.fromKey(refreshKey);
      final ttl = InvalidationTypesAdapter.fromKey(ttlKey);

      expect(refresh, equals(InvalidationTypes.refresh));
      expect(ttl, equals(InvalidationTypes.ttl));
    });

    test('should be able to get InvalidationTypes.refresh from invalid key successfully', () {
      const invalidKey = 'invalid';

      final refresh = InvalidationTypesAdapter.fromKey(invalidKey);

      expect(refresh, equals(InvalidationTypes.refresh));
    });
  });

  group('InvalidationTypesAdapter.toKey |', () {
    test('should be able to get key from InvalidationTypes successfully', () {
      final expectedRefreshKey = InvalidationTypes.refresh.name;
      final expectedTtlKey = InvalidationTypes.ttl.name;

      final refreshKey = InvalidationTypesAdapter.toKey(InvalidationTypes.refresh);
      final ttlKey = InvalidationTypesAdapter.toKey(InvalidationTypes.ttl);

      expect(refreshKey, equals(expectedRefreshKey));
      expect(ttlKey, equals(expectedTtlKey));
    });
  });
}
