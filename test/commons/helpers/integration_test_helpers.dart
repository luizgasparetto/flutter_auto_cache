import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:meta/meta.dart';
import 'package:fake_async/fake_async.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

@visibleForTesting
typedef FakeAsyncCallback = void Function(FakeAsync fakeAsync);

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
/// fakeAsyncTest('should handle timeouts correctly', (fakeAsync) async {
///   // Simulate passing time
///   fakeAsync.elapse(Duration(seconds: 1));
///
///   // Test assertions or other logic here
/// });
/// ```
@isTest
void fakeAsyncTest(String description, FakeAsyncCallback callback, {bool skip = false}) {
  test(description, () {
    fakeAsync((fakeAsync) {
      callback(fakeAsync);
    });
  }, skip: skip);
}

/// Initializes the preferences controller with optional configuration.
///
/// This asynchronous method sets up the preferences controller using shared preferences
/// with mock initial values and initializes the cache manager with a potentially custom configuration.
/// This setup is essential for managing application-specific preferences and cached data efficiently.
///
/// This function is intended to be used for testing purposes only. The use of `@visibleForTesting`
/// annotation indicates that it should not be used outside the context of tests unless absolutely necessary.
///
/// - [config] allows for customization of the cache configuration. If no config is provided,
///   the cache will be initialized with default settings.
///
/// Returns a `Future` that completes with an instance of `PrefsCacheManagerController`.
@visibleForTesting
Future<IDataCacheController> initializePrefsController({CacheConfiguration? config}) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues({});

  const defaultConfig = CacheConfiguration(sizeOptions: CacheSizeOptions(maxMb: 10));
  await AutoCacheInitializer.init(configuration: config ?? defaultConfig);

  return AutoCache.data;
}
