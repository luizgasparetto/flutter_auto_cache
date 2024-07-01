import 'package:mocktail/mocktail.dart';

/// An extension on the `When` class to provide an asynchronous void callback.
///
/// This extension adds a method `thenAsyncVoid` to the `When` class, which allows
/// you to specify an asynchronous function that returns `void` when a certain condition
/// is met.
extension WhenAsyncVoidExtension on When {
  /// Specifies an asynchronous function that returns `void` to be executed when
  /// the condition defined in `when` is met.
  ///
  /// This method sets an async function that completes with no result, providing
  /// a convenient way to handle asynchronous operations in mock setups without
  /// returning any value.
  void thenAsyncVoid() {
    thenAnswer((_) async {});
  }
}
