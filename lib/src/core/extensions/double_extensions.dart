import 'dart:math';

/// Extension on the [double] class to provide additional functionality for rounding.
extension DoubleExtensions on double {
  /// Rounds the double to 1 decimal place.
  ///
  /// This method scales the double by a factor of 10, rounds it to the nearest integer,
  /// and then scales it back down to one decimal place.
  ///
  /// Returns:
  ///   - The double value rounded to one decimal place.
  ///
  /// Example:
  /// ```dart
  /// double value = 3.25;
  /// double roundedValue = value.roundToDecimal();
  /// print(roundedValue); // Output: 3.3
  /// ```
  double roundToDecimal() {
    final scale = pow(10.0, 1); // Scale factor to move the decimal point for rounding
    final scaledNumber = this * scale; // Scale the original number

    // Round the scaled number to the nearest integer, convert to double, and adjust back by scale
    return scaledNumber.round().toDouble() / scale;
  }
}
