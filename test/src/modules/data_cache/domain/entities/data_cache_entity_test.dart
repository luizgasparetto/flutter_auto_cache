import 'package:flutter_auto_cache/src/core/domain/value_objects/cache_metadata.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeDataCacheEntity extends Fake implements DataCacheEntity {
  @override
  String get id => 'exclusive_id';
}

void main() {
  final baseCacheEntity = DataCacheEntity(id: 'exclusive_id', data: 'data', metadata: CacheMetadata.createDefault());
  final duplicateCacheEntity = DataCacheEntity(id: 'exclusive_id', data: 'data', metadata: CacheMetadata.createDefault());
  final differentIdCacheEntity = DataCacheEntity(id: 'different_id', data: 'data', metadata: CacheMetadata.createDefault());

  group('DataCacheEntity.equals |', () {
    test('should be able to validate equality of entities using the same id', () {
      expect(baseCacheEntity, equals(duplicateCacheEntity));
      expect(baseCacheEntity.hashCode, equals(duplicateCacheEntity.hashCode));
    });

    test('should NOT be able to validate equality of entities using different ids', () {
      expect(baseCacheEntity, isNot(equals(differentIdCacheEntity)));
      expect(baseCacheEntity.hashCode, isNot(equals(differentIdCacheEntity.hashCode)));
    });
  });
}
