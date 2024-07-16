import 'package:flutter_test/flutter_test.dart';

/// A custom matcher that checks if a given number is less than a specified value.
///
/// This matcher is useful in test cases where you need to verify that a numeric value
/// is less than a certain threshold. It provides a clean and readable way to perform
/// such checks using the `expect` function in Flutter tests.
///
/// Example usage:
/// ```dart
/// expect(5, isLessThan(10)); // Passes
/// expect(10, isLessThan(5)); // Fails
/// ```
Matcher isLessThan(num value) => _IsLessThan(value);

/// A private class that implements the custom matcher logic for `isLessThan`.
///
/// This class extends the `Matcher` class from the `flutter_test` package and provides
/// the implementation details for the custom matcher. It overrides the `matches` method
/// to perform the comparison and the `describe` method to provide a descriptive error
/// message when the match fails.
class _IsLessThan extends Matcher {
  final num value;

  _IsLessThan(this.value);

  /// Checks if the [item] matches the condition of being less than [value].
  ///
  /// This method is called by the `expect` function during test execution. It returns
  /// `true` if the [item] is a number and is less than [value]. If the [item] is not
  /// a number, it returns `false`.
  @override
  bool matches(item, Map matchState) {
    if (item is! num) return false;

    return item < value;
  }

  /// Describes the matcher for error messages.
  ///
  /// This method is used to generate a descriptive error message when the matcher fails.
  /// It adds a description of the expected condition to the provided [description], which
  /// helps in understanding why a particular test case failed.
  @override
  Description describe(Description description) => description.add('a value less than ').addDescriptionOf(value);
}
