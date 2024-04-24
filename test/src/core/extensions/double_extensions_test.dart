import 'package:auto_cache_manager/src/core/extensions/double_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoubleExtensions.roundToDecimal |', () {
    test('should be able to round a float number to ceil', () {
      const floatNumber = 5.45;
      final roundedNumber = floatNumber.roundToDecimal();

      expect(roundedNumber, equals(5.50));
    });

    test('should be able to round a float number to floor', () {
      const floatNumber = 5.03;
      final roundedNumber = floatNumber.roundToDecimal();

      expect(roundedNumber, equals(5));
    });
  });
}
