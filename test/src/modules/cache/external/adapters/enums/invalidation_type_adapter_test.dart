import 'package:auto_cache_manager/src/modules/cache/domain/enums/invalidation_type.dart';
import 'package:auto_cache_manager/src/modules/cache/external/adapters/enums/invalidation_type_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvalidationTypeAdapter.fromKey |', () {
    test('should be able to get InvalidationType from key successfully', () async {
      // Arrange
      const refreshKey = 'refresh';
      const ttlKey = 'ttl';

      // Act
      final refresh = InvalidationTypeAdapter.fromKey(refreshKey);
      final ttl = InvalidationTypeAdapter.fromKey(ttlKey);

      // Assert
      expect(refresh, equals(InvalidationType.refresh));
      expect(ttl, equals(InvalidationType.ttl));
    });

    test('should be able to get InvalidationType.refresh from invalid key successfully', () async {
      // Arrange
      const invalidKey = 'invalid';

      // Act
      final refresh = InvalidationTypeAdapter.fromKey(invalidKey);

      // Assert
      expect(refresh, equals(InvalidationType.refresh));
    });
  });

  group('InvalidationTypeAdapter.toKey |', () {
    test('should be able to get key from InvalidationType successfully', () async {
      // Arrange
      const expectedRefreshKey = 'refresh';
      const expectedTtlKey = 'ttl';

      // Act
      final refreshKey = InvalidationTypeAdapter.toKey(InvalidationType.refresh);
      final ttlKey = InvalidationTypeAdapter.toKey(InvalidationType.ttl);

      // Assert
      expect(refreshKey, equals(expectedRefreshKey));
      expect(ttlKey, equals(expectedTtlKey));
    });
  });
}
