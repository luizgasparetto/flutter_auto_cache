import 'package:flutter_auto_cache/src/modules/data_cache/domain/value_objects/invalidation_methods/invalidation_method.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sut = TTLInvalidationMethod();

  group('TTLInvalidationMethod.endAt |', () {
    test('should be able to get endAt based on the current time and the maximum TTL duration', () {
      final now = DateTime.now();
      final dateSimplified = DateTime(now.year, now.month, now.day);

      final response = sut.endAt;
      final responseSimplified = DateTime(response.year, response.month, response.day);

      expect(response.isAfter(DateTime.now()), isTrue);
      expect(responseSimplified.subtract(const Duration(days: 1)), equals(dateSimplified));
    });
  });
}
