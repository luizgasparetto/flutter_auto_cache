import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/config/cache_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/extensions/fake_async_extensions.dart';
import '../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues({});

  final config = CacheConfig(ttlMaxDuration: const Duration(milliseconds: 500));
  await AutoCacheManagerInitializer.instance.init(config: config);

  final sut = AutoCacheManager.prefs;

  group('GetCacheIntegrationTest.getString |', () {
    integrationTest('should be able to call getString and return NULL when doesnt have cache', (fakeAsync) {
      final response = fakeAsync.integrationAsync(() => sut.getString(key: 'my_key'));

      expect(response, isNull);
    });

    integrationTest('should be able to call getString and return DATA when have cache', (fakeAsync) {
      fakeAsync.integrationAsync(() => sut.saveString(key: 'my_key', data: 'custom_data'));

      final response = fakeAsync.integrationAsync(() => sut.getString(key: 'my_key'));

      expect(response, equals('custom_data'));
    });
  });
}
