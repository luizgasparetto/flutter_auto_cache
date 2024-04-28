import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:auto_cache_manager/src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';
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
/// integrationTest('should handle timeouts correctly', (fakeAsync) async {
///   // Simulate passing time
///   fakeAsync.elapse(Duration(seconds: 1));
///
///   // Test assertions or other logic here
/// });
/// ```
@isTest
void integrationTest(String description, FakeAsyncCallback callback, {bool skip = false}) {
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
Future<PrefsCacheManagerController> initializePrefsController({CacheConfig? config}) async {
  SharedPreferences.setMockInitialValues({});

  await AutoCacheManagerInitializer.instance.init(config: config);

  return AutoCacheManager.prefs;
}
