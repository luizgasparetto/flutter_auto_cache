import 'package:flutter_auto_cache/src/core/domain/failures/cache_time_details_failure.dart';
import 'package:flutter_auto_cache/src/core/domain/value_objects/cache_metadata.dart';
import 'package:flutter_auto_cache/src/core/shared/extensions/types/date_time_extensions.dart';
import 'package:flutter_auto_cache/src/core/shared/functional/either.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheMetadata.validate |', () {
    test('should be able to validate an instance of CacheMetadata successfully', () {
      final metadata = CacheMetadata(
        createdAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(days: 10)),
        updatedAt: DateTime.now().add(const Duration(days: 5)),
        usedAt: DateTime.now().add(const Duration(days: 5)),
      );

      final response = metadata.validate();

      expect(response.isSuccess, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<Unit>());
    });

    test('should NOT be able to validate when end_at is before created_at', () {
      final metadata = CacheMetadata(createdAt: DateTime.now(), endAt: DateTime.now().subtract(const Duration(days: 10)));

      final response = metadata.validate();

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<EndBeforeCreatedAtFailure>());
    });

    test('should NOT be able to validate when updated_at is before created_at', () {
      final metadata = CacheMetadata(createdAt: DateTime.now(), endAt: DateTime(2025), updatedAt: DateTime(2022));

      final response = metadata.validate();

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<UpdatedBeforeCreatedAtFailure>());
    });

    test('should NOT be able to validate when used_at is before created_at', () {
      final metadata = CacheMetadata(createdAt: DateTime.now(), endAt: DateTime(2025), usedAt: DateTime(2022));

      final response = metadata.validate();

      expect(response.isError, isTrue);
      expect(response.fold((l) => l, (r) => r), isA<UsedBeforeCreatedAtFailure>());
    });
  });

  group('CacheMetadata.save |', () {
    test('should be able to create an CacheMetadata to save purpouse and validate props', () {
      final response = CacheMetadata.save(endAt: DateTime(2025));

      expect(response.createdAt.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.endAt, equals(DateTime(2025)));
      expect(response.usedAt, isNull);
      expect(response.updatedAt, isNull);
    });
  });

  group('CacheMetadata.update |', () {
    test('should be able to create an CacheMetadata to update purpouse and validate props', () {
      final metadata = CacheMetadata(createdAt: DateTime(2023), endAt: DateTime(2023));

      final response = metadata.update(endAt: DateTime(2024));

      expect(response.createdAt, equals(DateTime(2023)));
      expect(response.endAt, equals(DateTime(2024)));
      expect(response.updatedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
      expect(response.usedAt, isNull);
    });
  });

  group('CacheMetadata.used |', () {
    test('should be able to create an CacheMetadata to used purpouse and validate props', () {
      final metadata = CacheMetadata(createdAt: DateTime(2023), endAt: DateTime(2023));

      final response = metadata.used();

      expect(response.createdAt, equals(DateTime(2023)));
      expect(response.endAt, equals(DateTime(2023)));
      expect(response.updatedAt, equals(metadata.updatedAt));
      expect(response.usedAt?.withoutMilliseconds(), equals(DateTime.now().withoutMilliseconds()));
    });
  });

  group('CacheMetadata.equals |', () {
    test('should be able to validate equality when have the same values', () {
      final firstInstance = CacheMetadata(createdAt: DateTime(2022), endAt: DateTime(2022));
      final secondInstance = CacheMetadata(createdAt: DateTime(2022), endAt: DateTime(2022));

      expect(firstInstance == secondInstance, isTrue);
      expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
    });
  });
}
