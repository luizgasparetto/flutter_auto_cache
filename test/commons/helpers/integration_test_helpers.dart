import 'package:meta/meta.dart';
import 'package:fake_async/fake_async.dart';

import 'package:flutter_test/flutter_test.dart';

/// Executes an integration test with a controlled asynchronous environment.
///
/// This function utilizes `FakeAsync` to allow fine-grained control over time-based operations
/// within the test. It is ideal for testing features that depend on timing or asynchronous logic.
///
/// - [description] provides a string description of what the test is expected to accomplish.
/// - [callback] is an asynchronous function that takes a `FakeAsync` instance. This callback
///   should contain the test logic, including any asynchronous operations and time manipulations.
///   The callback must return a `Future` to handle asynchronous operations properly.
///
/// Usage example:
/// ```dart
/// integrationTest('should handle timeouts correctly', (fakeAsync) async {
///   // Simulate passing time
///   fakeAsync.elapse(Duration(seconds: 1));
///
///   // Test assertions or other logic here
/// });
/// ```
@isTest
void integrationTest(String description, void Function(FakeAsync fakeAsync) callback) {
  test(description, () {
    fakeAsync((fakeAsync) {
      callback(fakeAsync);
    });
  });
}
