import 'package:flutter_auto_cache/src/modules/data_cache/domain/enums/invalidation_types.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/adapters/enums/invalidation_types_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvalidationTypesAdapter.fromKey |', () {
    test('should be able to get InvalidationTypes from key successfully', () {
      final ttlKey = InvalidationTypes.ttl.name;
      final ttl = InvalidationTypesAdapter.fromKey(ttlKey);

      expect(ttl, equals(InvalidationTypes.ttl));
    });

    test('should be able to get InvalidationTypes.refresh from invalid key successfully', () {
      const invalidKey = 'invalid';
      final refresh = InvalidationTypesAdapter.fromKey(invalidKey);

      expect(refresh, equals(InvalidationTypes.ttl));
    });
  });

  group('InvalidationTypesAdapter.toKey |', () {
    test('should be able to get key from InvalidationTypes successfully', () {
      final expectedTtlKey = InvalidationTypes.ttl.name;
      final ttlKey = InvalidationTypesAdapter.toKey(InvalidationTypes.ttl);

      expect(ttlKey, equals(expectedTtlKey));
    });
  });
}
