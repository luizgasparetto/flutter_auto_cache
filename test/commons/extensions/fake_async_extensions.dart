import 'package:fake_async/fake_async.dart';

/// Extension that adds the `integrationAsync` method to `FakeAsync`.
///
/// This method facilitates the execution of asynchronous operations within a controlled
/// environment managed by `FakeAsync`, allowing microtasks to be completed immediately after invocation.
/// It is particularly useful for simplifying integration tests that depend on asynchronous logic.
///
/// The method captures the result of the asynchronous function and returns it,
/// ensuring all microtasks are flushed before concluding the test step.
extension FakeAsyncMethodExtension on FakeAsync {
  Future<T> integrationAsync<T>(Future<T> Function() callback) async {
    final response = await callback.call();

    this.elapse(const Duration(seconds: 1));
    this.flushMicrotasks();

    return response;
  }
}
