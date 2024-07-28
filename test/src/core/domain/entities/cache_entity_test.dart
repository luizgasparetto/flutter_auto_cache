import 'package:flutter_auto_cache/src/core/domain/entities/cache_entity.dart';
import 'package:flutter_auto_cache/src/core/domain/value_objects/cache_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheEntity.equals |', () {
    test('should be able to validate equality when two entities have the same id', () {
      final firstInstance = CacheEntity(id: 'id', data: 'any_data', metadata: CacheMetadata.createDefault());
      final secondInstance = CacheEntity(id: 'id', data: 'different_data', metadata: CacheMetadata.createDefault());

      expect(firstInstance == secondInstance, isTrue);
      expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
    });

    test('should NOT  be able to validate equality when two entities have different id', () {
      final firstInstance = CacheEntity(id: 'first_id', data: 'any_data', metadata: CacheMetadata.createDefault());
      final secondInstance = CacheEntity(id: 'second_id', data: 'different_data', metadata: CacheMetadata.createDefault());

      expect(firstInstance != secondInstance, isTrue);
      expect(firstInstance.hashCode != secondInstance.hashCode, isTrue);
    });
  });
}
