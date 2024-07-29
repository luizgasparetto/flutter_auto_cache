import 'package:flutter_auto_cache/src/core/domain/value_objects/cache_metadata.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/adapters/cache_metadata_adapter.dart';
import 'package:flutter_auto_cache/src/core/shared/extensions/types/date_time_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final json = {
    'created_at': DateTime.now().toIso8601String(),
    'end_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
    'used_at': DateTime.now().toIso8601String(),
  };

  group('CacheMetadataAdapter.fromJson |', () {
    test('should be able to parse JSON into a CacheMetadata', () {
      final response = CacheMetadataAdapter.fromJson(json);

      expect(response.createdAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.endAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.updatedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.usedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
    });
  });

  group('CacheMetadataAdapter.toJson |', () {
    final metadata = CacheMetadata(
      createdAt: DateTime.now().withoutMilliseconds(),
      endAt: DateTime.now().withoutMilliseconds(),
      updatedAt: DateTime.now().withoutMilliseconds(),
      usedAt: DateTime.now().withoutMilliseconds(),
    );

    test('should be able to check keys when parse a CacheMetadata into JSON', () {
      final response = CacheMetadataAdapter.toJson(metadata);

      expect(response.containsKey('created_at'), isTrue);
      expect(response.containsKey('end_at'), isTrue);
      expect(response.containsKey('updated_at'), isTrue);
      expect(response.containsKey('used_at'), isTrue);
    });

    test('should be able to check values when parse a CacheMetadata into JSON', () {
      final response = CacheMetadataAdapter.toJson(metadata);

      expect(response['created_at'], equals(DateTime.now().withoutMilliseconds().toIso8601String()));
      expect(response['end_at'], equals(DateTime.now().withoutMilliseconds().toIso8601String()));
      expect(response['updated_at'], equals(DateTime.now().withoutMilliseconds().toIso8601String()));
      expect(response['used_at'], equals(DateTime.now().withoutMilliseconds().toIso8601String()));
    });
  });
}
