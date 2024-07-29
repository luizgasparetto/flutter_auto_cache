import 'package:meta/meta.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/shared/services/cache_size_service/value_objects/cache_size_options.dart';

/// Initializes the data controller with optional configuration.
///
/// This asynchronous method sets up the data controller using shared preferences
/// with mock initial values and initializes the cache manager with a potentially custom configuration.
/// This setup is essential for managing application-specific preferences and cached data efficiently.
///
/// This function is intended to be used for testing purposes only. The use of `@visibleForTesting`
/// annotation indicates that it should not be used outside the context of tests unless absolutely necessary.
///
/// - [config] allows for customization of the cache configuration. If no config is provided,
///   the cache will be initialized with default settings.
///
/// Returns a `Future` that completes with an instance of `IDataCacheController`.
@visibleForTesting
Future<IDataCacheController> initializeDataController({CacheConfiguration? config}) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues({});

  const defaultConfig = CacheConfiguration(sizeOptions: CacheSizeOptions(maxMb: 10));
  await AutoCacheInitializer.initialize(configuration: config ?? defaultConfig);

  return AutoCache.data;
}
